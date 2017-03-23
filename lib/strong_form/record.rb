module StrongForm
  module Record
    attr_accessor :permitted_attributes

    # allows to check if nested attributes are allowed
    #
    # permitted_nested_attributes?(:addresses) is true if
    # :addresses_attributes is permitted or everything is permitted
    def permitted_nested_attributes?(attr)
      permitted_attributes.nil? ||
        permitted_attributes == true ||
        permitted_attributes.any? do |o|
          o.is_a?(Hash) && o.keys.include?("#{attr}_attributes".to_sym)
        end
    end
  end
end
