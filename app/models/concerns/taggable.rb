module Tggable
  extend ActiveSupport::Concern
  include do
    has_many :taggings, dependent: :delete_all
    has_many :tags, through: :taggings
    scope :tagged, ->(name) {joins(:tags).where(tags: {name: name})}
  end
  def tag_list = tags.map(&:name).join(",")
  def tag_list=(value)
    names = value.to_s.split(",").map(&:strip).compact_blank.uniq
    Tag.upsert_all(names.map {|name| {name:}}, unique_by: :name) if names.any?
    self.tags = Tag.where(name:names)
    
  end
end