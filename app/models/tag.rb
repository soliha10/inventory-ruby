class Tag < ApplicationRecord
  has_many :taggings, dependent: :delete_all
  has_many :inventories, through: :taggings
  validates :name, presence: true, uniqueness: true
  scope :starting_with, ->(text) {where("name ILIKE ?", "#{sanitize_sql_like(text.to_s)}%").order(:name).limit(10)}
  scope :cloud, ->{joins(:taggings).group(:id).select("tags.*, COUNT(taggings.id) AS uses").order("uses DESC").limit(40)}
end