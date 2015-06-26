module NestedForm
  module BuilderMixin
    alias_method :orig_link_to_add, :link_to_add

    def link_to_add(association, options = {}, &block)
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

      orig_link_to_add(association, options, &block)
    end
  end
end
