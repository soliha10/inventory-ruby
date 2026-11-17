class Post < ApplicationRecord
  belongs_to :inventory
  belongs_to :user
  validates :body, presence: true
  after_create_commit -> { broadcast_append_to inventory, target: "posts"}
end