module Admin 
class UsersController < ApplicationController
OPERATIONS = {"block" => {blocked: true}, "unblock" => {blocked: false}, 
               "promote" => {admin: true}, "demote" => {admin: false} }.freeze
before_action :require_admin
def index = @users = User.order(:name).page(params[:page])
def bulk
selected = User.where(id: params[:ids])
params[:operation] == "destroy" ? selected.destroy_all : selected.update_all(OPERATIONS.fetch(params[:operation]))
redirect_to admin_users_path, notice: t(".done")
end
private
def require_admin = (redirect_to root_path, alert: t("flash.denied") unless current_user&.admin? )
end
end