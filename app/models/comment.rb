class Comment < ApplicationRecord
  validates_presence_of :content, :score

  default_scope { order(created_at: :desc)}

  belongs_to :user
  belongs_to :restaurant
end
