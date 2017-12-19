class Comment < ApplicationRecord
  validates_presence_of :content, :score

  belongs_to :user
  belongs_to :restaurant
end
