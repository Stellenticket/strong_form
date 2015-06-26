class User < ActiveRecord::Base
  has_many :addresses
  accepts_nested_attributes_for :addresses

  has_one :tag, as: :taggable
  accepts_nested_attributes_for :tag
end
