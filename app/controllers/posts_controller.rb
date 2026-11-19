class PostsController < ApplicationController
include InventoryScoped
before_action :authenticate_user!

def create
@inventory.posts.create(user: current_user, body: params.require(:post)[:body])
render turbo_stream: turbo_stream.replace("post_form", partial: "posts/form", locals:{inventory: @inventory } )
end
end