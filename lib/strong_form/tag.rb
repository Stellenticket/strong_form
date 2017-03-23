module StrongForm
  module Tag
    extend ActiveSupport::Concern
    included do
      alias_method :render_orig, :render

      def render
        object.respond_to?(:permitted_attributes) &&
          !object.permitted_attributes.nil? &&
          disable_unless_permitted
        render_orig
      end
    end

    private

    def disable_unless_permitted
      options = @html_options || @options
      return if options.key?(:disabled)

      options[:disabled] =
        !StrongForm::Helper.attribute_permitted?(@method_name, object.permitted_attributes)
    end
  end
end
