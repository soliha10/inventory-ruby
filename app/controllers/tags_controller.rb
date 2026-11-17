class TagsController < ApplicationController
  def index
    render json: Tag.starting_with(params[:q]).pluck(:name).map { |name| {value: name, text: name} }
  end
end