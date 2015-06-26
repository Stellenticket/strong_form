module StrongForm
  module Finder
    def self.find_child_permitted_attributes(name, permitted_attributes)
      # find the hash with the key `child_models_attributes`
      attributes = permitted_attributes.find do |o|
        o.is_a?(Hash) && o.keys.include?(name)
      end

      return [] unless attributes

      attributes = attributes[name]
      attributes = [attributes] unless attributes.is_a?(Array)
      attributes
    end
  end
end
