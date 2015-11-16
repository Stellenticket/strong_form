class Address < ActiveRecord::Base
  belongs_to :user

  has_many :tags, as: :taggable
  accepts_nested_attributes_for :tags
  accepts_nested_attributes_for :user
end
