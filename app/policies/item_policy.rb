class ItemPolicy < ApplicationPolicy
  def show? = true
  def create? = record.inventory.writable_by?(user)
  alias new? create?
  alias update? create?
  alias destroy? create?
end