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
        object.permitted_attributes != true &&
        object.permitted_attributes.none? do |entry|
          entry.is_a?(Hash) &&
            entry.keys.include?(@method_name.to_sym) ||
            entry == @method_name.to_sym
        end
    end
  end
end
