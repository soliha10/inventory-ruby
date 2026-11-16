class PreferencesController < ApplicationController
    def update
      session.update(prefrence_params)
      current_user&.update(prefrence_params)
      redirect_back_or_to root_path, notice: t('.success')
    end
    private
    def prefrence_params = params.permit(:locale, :theme).to_h
end