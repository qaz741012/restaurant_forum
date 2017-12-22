class Restaurant < ApplicationRecord
  validates_presence_of :name
  mount_uploader :image, PhotoUploader

  belongs_to :category

  has_many :comments
  has_many :users, through: :comments
end
