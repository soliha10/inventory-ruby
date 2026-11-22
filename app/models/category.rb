class Category < ApplicationRecord
  has_many :inventories, dependent: :restrict_with_error
  validates :name, presence: true, uniqueness: true
  def self.ransackable_attributes(_auth =nil) =%w[name]
end