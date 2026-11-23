module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2 = sign_in_from_provider
    def github = sign_in_from_provider
    def facebook = sign_in_from_provider

    private
    def sign_in_from_provider
      user = User.from_omniauth(request.env["omniauth.auth"])
      user.active_for_authentication? ? sign_in_and_redirect(user) : redirect_to(new_user_session_path, alert: t("devise.failure.blocked"))
    end
  end 
end
