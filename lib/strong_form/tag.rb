module StrongForm
  module Tag
    def render
      if object.respond_to?(:permitted_attributes) && !object.permitted_attributes.nil?
        (@html_options || @options)[:disabled] ||=
          object.permitted_attributes != true &&
          !object.permitted_attributes.include?(@method_name.to_sym)
      end
      super
    end
  end
end
