class  ApplicationController < ActionController::Base
  include Pundit::Authorization
  include Preferences
  allow_browser versions: :modern
  before_action :permit_sign_up_name, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :deny_access

  private
  def permit_sign_up_name = devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  def deny_access = redirect_back_or_to root_path, alert: t("flash.denied")
  def flash_stream(type, message) = turbo_stream.replace("flash", partial: "shared/flash", locals: {messages: {type=>message}} )
end   
