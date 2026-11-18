class ItemsController < ApplicationController
 include InventoryScoped
 before_action :authenticate_user!, except: :show 
 before_action :set_item, only: %i[show update]
 def new = @item = authorize(@inventory.items.build(custom_id: @inventory.generate_custom_id))

 def create 
  @item = authorize(@inventory.items.build(item_params.merge(creator: current_user)))
  @item.save ? redirect_to(@inventory, notice: t(".created")) : render(:new, status: :unprocessable_entity)
 rescue ActiveRecord::RecordNotUnique
  reject_duplicate(:new)
 end
 def update
authorize(@item).update(item_params) ? redirect_to(@inventory, notice: t(".updated")) : render(:show, status: :unprocessable_entity)
 rescue ActiveRecord::StaleObjectError
  reject(:show, :base, :stale)
 rescue Activerecord::RecordNotUnique
  reject_duplicate(:show)
 end
 def destroy_many
  authorize(Item.new(inventory: @inventory), :destroy? )
  @inventory.items.where(id: params[:ids]).delete_all
  redirect_to @inventory, notice: t(".deleted")
 end
 private
 def set_item = @item = @inventory.items.find(params[:id])
  def item_params = params.require(:item).permit(:custom_id, :lock_version, *@inventory.field_columns)
  def reject_duplicate(view) = reject(view, :custom_id, :taken)
  def reject(view, attribute, error)
    @item.errors.add(attribute, error)
    render view, status: :unprocessable_entity

  end

end