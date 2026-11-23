class HomeController < ApplicationController
def index
@latest = Inventory.latest.includes(:creator, :category).limit(10)
@popular = Inventory.popular.includes(:creator, :category).limit(5)
@tags = Tag.cloud
end
def privacy; end
end