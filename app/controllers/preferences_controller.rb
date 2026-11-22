class PreferencesController < ApplicationController
    def update
      session.update(preference_params)
      current_user&.update(preference_params)
      redirect_back_or_to root_path
    end
    private
    def preference_params = params.permit(:locale, :theme).to_h
end