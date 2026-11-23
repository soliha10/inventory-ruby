Rails.application.routes.draw do 
 devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}

  root "home#index"
  get "search", to: "search#index"
  get "privacy", to: "home#privacy"
  resource :preferences, only: :update
  resources :tags, only: :index
  resources :users, only: %i[index show]

  resources :inventories, only: %i[new create show update] do
member do 
%i[settings custom_id access fields stats discussion].each { |tab| get tab }
post :id_preview
end
delete :destroy_many, on: :collection
resources :items, only: %i[new create show update] do
delete :destroy_many, on: :collection
end
resources :accesses, only: :create do 
delete :destroy_many, on: :collection
end
resources :posts, only: :create
  end
resources :items, only: [] do
resource :like, only: %i[create destroy]
end
namespace :admin do 
resources :users, only: :index do
patch :bulk, on: :collection
end
end
get "up" => "rails/health#show", as: :rails_health_check
end 