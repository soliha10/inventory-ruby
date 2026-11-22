class InventoriesController < ApplicationController
  OWNER_TABS = %w[settings custom_id access fields].freeze
  PERMITTED = [:title, :description, :category_id, :tag_list, :image, :public, :lock_version, {fields_attributes: %i[id kind title description show_in_table position _destroy], id_elements_attributes: %i[id kind value position _destroy]}].freeze
  before_action :authenticate_user!, except: %i[show discussion stats]
  before_action :set_inventory, except: %i[new create destroy_many]
  before_action -> {authorize @inventory, :update?}, only:[*OWNER_TABS, :update, :id_preview]

  def show = @items = @inventory.items.order(:created_at).page(params[:page])
  def discussion = @posts = @inventory.posts.includes(:user)
  def stats = @stats = InventoryStats.new(@inventory)
  def access = @writers = @inventory.writers.order(params[:sort] == "email" ? :email : :name )
  def new = @inventory = authorize(current_user.inventories.build)
  def create 
    @inventory = authorize(current_user.inventories.build(inventory_params))
    @inventory.save ? redirect_to(settings_inventory_path(@inventory)) : render(:new, status: :unprocessable_entity)
  end
def update
  saved = @inventory.update(inventory_params)
  @inventory.reload if saved
  render turbo_stream: [replace_tab_form, flash_stream(*save_message(saved))]
rescue ActiveRecord::StaleObjectError
  render turbo_stream: flash_stream(:alert, t(".conflict")), status: :conflict
end
  def id_preview
    @inventory.assign_attributes(inventory_params)
    render plain: @inventory.generate_custom_id
  end
  def destroy_many
    Inventory.manageable_by(current_user).where(id: params[:ids]).destroy_all
    redirect_back_or_to user_path(current_user), notice: t(".deleted")
  end
private

def set_inventory = @inventory = Inventory.find(params[:id])
  def inventory_params = params.require(:inventory).permit(*PERMITTED).tap { |attrs| attrs.delete(:image) if attrs[:image].blank? }
  def current_tab = params[:tab].presence_in(OWNER_TABS) || OWNER_TABS.first
  def replace_tab_form = turbo_stream.replace("inventory_form", partial: "inventories/forms/#{current_tab}", locals: {inventory: @inventory} , method: :morph )
  def save_message(saved) = saved ? [:notice, t(".saved")] : [:alert, @inventory.errors.full_messages.to_sentence]
end