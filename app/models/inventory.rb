class Inventory < ApplicationRecord
 include PgSearch::Model
 include Taggable

 belongs_to :creator, class_name: "User"
 belongs_to :category
 has_many :items, dependent: :delete_all
 has_many :accesses, dependent: :delete_all
  has_many :writers, through: :accesses, source: :user
 has_many :posts, -> {order(:created_at)}, dependent: :delete_all
 has_one_attached :image
 validates :title, presence:true
 before_save :bump_version
 pg_search_scope :search, against: %i[title description], associated_against: {tags: :name}, using: {tsearch: {prefix: true}}
 scope :latest, -> {order(created_at: :desc)}
 scope :popular, -> {left_joins(:items).group(:id).order(Arel.sql("COUNT(items.id) DESC"))}
 scope :manageable_by, ->(user) {user.admin? ? all : where(creator: user)}
 def self.ransackable_attributes(_auth = nil) = %w[title description created_at]
 def self.ransackable_associations(_auth = nil) = %w[category creator]
def owned_by?(user) = user.present? && (user.admin? || creator_id == user.id)
def writable_by?(user) = owned_by?(user) || (user.present? && (public? ||accesses.exists?(user_id: user.id)))
  private
  def bump_version = self.updated_at = Time.current
end