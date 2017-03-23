module StrongForm
  module Finder
    def self.find_child_permitted_attributes(name, permitted_attributes)
      attributes = permitted_attributes.find do |o|
        o.is_a?(Hash) && o.keys.include?(name)
      end

      return [] unless attributes

      Array.wrap(attributes[name])
    end
  end
end
