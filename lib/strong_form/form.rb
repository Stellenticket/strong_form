module ActionView
  module Helpers
    module FormHelper
      alias orig_form_for form_for

      def form_for(record, options = {}, &block)
        object = record.is_a?(Array) ? record.last : record

        if options.key?(:permitted_attributes) && object.respond_to?(:permitted_attributes=)
          object.permitted_attributes = options.delete(:permitted_attributes)
        end

        orig_form_for(record, options, &block)
      end

      def assign_child_permitted_attributes!(
        record_name, record_object, parent_permitted_attributes
      )
        if parent_permitted_attributes == true # parent allowed everything
          record_object.permitted_attributes = parent_permitted_attributes
          return
        end

        # search for nested attributes

        # record_name is of the form `user[child_models_attributes][0]`
        # extract `child_models_attributes`
        permitted_name =
          record_name.match(/.*?\[([^\]\[]+)\](\[[0-9]+\])?$/)[1].to_sym

        # find the hash with the key `child_models_attributes`
        record_object.permitted_attributes =
          StrongForm::Helper.find_child_permitted_attributes(
            permitted_name, parent_permitted_attributes
          )
      end
      private :assign_child_permitted_attributes!

      # https://github.com/rails/rails/blob/4-2-stable/actionview/lib/action_view/helpers/form_helper.rb#L712
      def fields_for(record_name, record_object = nil, options = {}, &block)
        if record_object.respond_to?(:permitted_attributes=)
          if options.key?(:permitted_attributes)
            record_object.permitted_attributes = options[:permitted_attributes]
          elsif options[:parent_builder].object.try(:permitted_attributes) &&
                record_object.permitted_attributes.nil?
            assign_child_permitted_attributes!(
              record_name, record_object, options[:parent_builder].object.permitted_attributes
            )
          end
        end

        builder = instantiate_builder(record_name, record_object, options)
        capture(builder, &block)
      end
    end
  end
end

module ActionView
  module Helpers
    class FormBuilder
      def attribute_permitted?(name)
        StrongForm::Helper.attribute_permitted?(name, object.try(:permitted_attributes))
      end
    end
  end
end
