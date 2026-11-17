module InventoriesHelper
 PUBLIC_TABS = %w[show discussion stats].freeze
 def inventory_tabs(inventory) = policy(inventory).update? ? PUBLIC_TABS + InventoriesController::OWNED_TABS : PUBLIC_TABS
 def tab_path(inventory, tab) = tab == "show" ? inventory_path(inventory) : public_send("#{tab}_inventory_path", inventory)
 def kind_options(model) = model::KINDS.map { |kind| [kind_name(model, kind), kind] }
 def kind_name(model, kind) = t("kinds.#{model.model_name.i18n_key}.#{kind}")
  def inventory_image(inventory) = inventory.image.attached? ? image_tag(inventory.image, class: "img-thumbnail inventory-image") : ""




end