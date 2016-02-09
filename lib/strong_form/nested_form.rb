module StrongForm
  module NestedForm
    extend ActiveSupport::Concern

    included do
      alias_method :orig_link_to_add, :link_to_add
      alias_method :orig_link_to_remove, :link_to_remove

      def link_to_add(*args, &block)
        options = args.extract_options!.symbolize_keys
        association = args.pop

        if object.respond_to?(:permitted_attributes)
          return unless object.permitted_nested_attributes?(association)

          unless options[:model_object]
            reflection = object.class.reflect_on_association(association)
            options[:model_object] = reflection.klass.new
          end

          unless options[:model_object].permitted_attributes.present?
            if object.permitted_attributes == true || object.permitted_attributes.nil?
              options[:model_object].permitted_attributes = true
            else
              options[:model_object].permitted_attributes =
                StrongForm::Finder.find_child_permitted_attributes(
                  "#{association}_attributes".to_sym, object.permitted_attributes
                )
            end
          end
        end

        orig_link_to_add(*args, association, options, &block)
      end

      def link_to_remove(*args, &block)
        return if object.respond_to?(:permitted_attributes) &&
                  !object.permitted_attributes.nil? &&
                  object.permitted_attributes != true &&
                  !object.permitted_attributes.include?(:_destroy)
        orig_link_to_remove(*args, &block)
      end
    end
  end
end
