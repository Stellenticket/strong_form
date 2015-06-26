module ActionView
  module Helpers
    module FormHelper
      alias_method :orig_form_for, :form_for

      attr_accessor :permitted_attributes

      def form_for(record, options = {}, &block)
        # explicilty passed
        if options.key?(:permitted_attributes)
          self.permitted_attributes = options.delete(:permitted_attributes)
          record.permitted_attributes =
            permitted_attributes if record.respond_to?(:permitted_attributes=)
        # assigned to object
        elsif record.respond_to?(:permitted_attributes)
          self.permitted_attributes = record.permitted_attributes
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
        # try to extract `child_models_attributes`
        permitted_name =
          record_name.match(/.*?\[([^\]\[]+)\](\[[0-9]+\])?$/)[1].to_sym

        # find the hash with the key `child_models_attributes`
        child_attributes =
          parent_permitted_attributes.find do |o|
            o.is_a?(Hash) && o.keys.include?(permitted_name)
          end

        if child_attributes
          # set our records permitted attributes
          child_attributes = child_attributes[permitted_name]
          child_attributes = [child_attributes] unless child_attributes.is_a?(Array)
          record_object.permitted_attributes = child_attributes
        else
          # allow nothing
          record_object.permitted_attributes = []
        end
      end
      private :assign_child_permitted_attributes!

      # https://github.com/rails/rails/blob/4-2-stable/actionview/lib/action_view/helpers/form_helper.rb#L712
      def fields_for(record_name, record_object = nil, options = {}, &block)
        assign_child_permitted_attributes!(
          record_name, record_object, options[:parent_builder].object.permitted_attributes
        ) if permitted_attributes && record_object.respond_to?(:permitted_attributes=)

        builder = instantiate_builder(record_name, record_object, options)
        capture(builder, &block)
      end
    end
  end
end
