class Field < ApplicationRecord
  KINDS=%w[string text number link boolean].freeze
  LIMIT=3
  belongs_to :inventory
  validates :title, presence:true
  validates :kind, inclusion: {in: KINDS}
  after_destroy :clear_item_values
  def column = "#{kind}_#{slot}"
  private
  def clear_item_values = inventory.items.update_all(column => nil)
    
end