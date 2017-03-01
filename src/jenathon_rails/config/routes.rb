Rails.application.routes.draw do
  # users
  resources :users
  
  # administration UI
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # routing for the home page
  root "static_pages#home"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
