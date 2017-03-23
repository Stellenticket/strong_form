module StrongForm
  module Helper
    def self.find_child_permitted_attributes(name, permitted_attributes)
      attributes = permitted_attributes.find do |o|
        o.is_a?(Hash) && o.keys.include?(name)
      end

      return [] unless attributes

      Array.wrap(attributes[name])
    end

    def self.attribute_permitted?(name, permitted_attributes)
      return false if permitted_attributes.blank?

      permitted_attributes == true ||
        permitted_attributes.any? do |entry|
          entry.is_a?(Hash) &&
            entry.keys.include?(name.to_sym) ||
            entry == name.to_sym
        end
    end
  end
end
