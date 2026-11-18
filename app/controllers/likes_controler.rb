class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action -> {@item = Item.find(params[:item_id]) }

  def create
    @item.likes.find_or_create_by!(user: current_user)
    render_button

  end
  def destroy
    @item.likes.where(user: current_user).delete_all
    render_button
  end
  private
  def render_button = render(turbo_stream: turbo_stream.replace("like_button", partioal: "likes/button", locals: {item: @item} ) )

end