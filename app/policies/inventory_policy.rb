class InventoryPolicy < ApplicationPolicy
  def show? = true
  def create? = user.present?
  alias new? create?
  def update? = record.owned_by?(user)
  def write_items? = record.writable_by?(user)
end