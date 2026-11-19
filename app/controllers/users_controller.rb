class UsersController < ApplicationController
 before_action :authenticate_user!, only: :index
 def index
render json: User.matching(params[:q]).order(:name).limit(10).map { |user| {value: user.id, text: "#{user.name} <#{user.email}>" } }
 end

 def show
   @user = User.find(params[:id])
   @owned = @user.inventories.ransack(params[:owned], search_key: :owned)
   @shared = @user.writable_inventories.ransack(params[:shared], search_key: :shared)
 end
end