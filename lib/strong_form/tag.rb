module StrongForm
  module Tag
    extend ActiveSupport::Concern
    included do
      alias_method :render_orig, :render

      def render
        if object.respond_to?(:permitted_attributes) && !object.permitted_attributes.nil?
          (@html_options || @options)[:disabled] ||=
            object.permitted_attributes != true &&
            (
              !object.permitted_attributes.include?(@method_name.to_sym) &&
              !object.permitted_attributes.include?("#{@method_name}": [])
            )
        end
        render_orig
      end
    end
  end
end
