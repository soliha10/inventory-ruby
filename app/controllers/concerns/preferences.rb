module Preferences
  extend ActiveSupport::Concern
  included do
    around_action :switch_locale
    helper_method :current_theme
  end
  private
  def switch_locale(&) = I18n.with_locale(current_locale, &)
  def current_locale=(current_user&.locale || session[:locale]).presence_in(User::LOCALES) || I18n.default_locale
  def current_theme=(current_user&.theme || session[:theme]).presence_in(User::THEMES) || User::THEMES.first
 
end