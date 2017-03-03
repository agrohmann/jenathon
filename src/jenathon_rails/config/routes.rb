Rails.application.routes.draw do
  # users
  resources :users

  # administration UI
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # routing for the home page
  root "static_pages#home"

  # api placeholders
  concern :api_controllers do
    resources :users, :only => [:index, :show, :create, :update, :destroy]
  end

  # api routing using concerns
  scope :module => :api do
    # specific version routing
    scope :module => :v1, :path => '/api/v1' do
      concerns :api_controllers
    end

    # latest version routing
    scope :module => :v1, :path => '/api' do
      concerns :api_controllers
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
