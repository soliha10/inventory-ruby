class Item < ApplicationRecord
include PgSearch::Model
SEARCHABLE = (1..3).flat_map { |n| ["string_#{n}", "text_#{n}"]}.freeze
belongs_to :inventory
belongs_to :creator, class_name: "User"
has_many :likes, dependent: :delete_all
validates :custom_id, presence: true, uniqueness: {scope: :inventory_id}
validate :custom_id_matches_format, on: :update, if: :custom_id_changed?
before_validation :assign_custom_id, on: :create
pg_search_scope :search, aaginst: [:custom_id, *SEARCHABLE], using: {tsearch: {prefix: true}}
def liked_by?(user) = user.present? && likes.exists?(user_id: user.id)
  private
  def assign_custom_id
    self.sequence_number = inventory.next_sequence
    self.custom_id = custom_id.presence || inventory.generate_custom_id(sequence_number).presence || sequence_number.to_s
  end
  def custom_id_matches_format
    errors.add(:custom_id, :invalid_format) unless inventory.custom_id_format.match?(custom_id)
  end
end