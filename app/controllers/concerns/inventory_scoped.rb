module InventoryScoped
 extend ActiveSupport::Concern

  included do
  before_action :set_inventory
  end
  private 
  def set_inventory = @inventory = Inventory.find(params[:inventory_id])
end