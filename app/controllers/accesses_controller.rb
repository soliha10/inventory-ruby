class AccessesController  < ApplicationController
 include InventoryScoped
 before_action :authenticate_user!
 before_action -> {authorize @inventory, :update?}

 def create 
@inventory.accesses.find_or_create_by!(user_id: params[:user_id]) if params[:user_id].present?
redirect_to access_inventory_path(@inventory)
 end
 def destroy_many
 @inventory.accesses.where(user_id: params[:ids]).delete_all
 redirect_to access_inventory_path(@inventory)
 end
 
end