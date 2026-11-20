class SearchController < ApplicationController
LIMIT=50
def index
@inventories = matching_inventories.includes(:creator, :category).limit(LIMIT)
@items = params[:tag] ? Item.none : Item.search(params[:q]).includes(:inventory).limit(LIMIT)
end
private 
def matching_inventories = params[:tag] ? Inventory.tagged(params[:tag]) : Inventory.search(params[:q])
end