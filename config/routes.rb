HeisenBugDev::Application.routes.draw do
  get "users/show"
  root 'home#home'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } do
    get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
    delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  namespace :projects do
    get :autocomplete_user_name
    delete :remove_user
  end

  resources 'rasterizer', :only => [:create]
  resources 'artifacts',  :only => [:create]
  resources 'builds',     :only => [:create]
  resources 'users'
  resources 'projects'

  namespace :users do
    match '/update_token', :to => 'token#update', :via => 'put'
  end

  match '/downloads', :to => 'builds#index', :via => 'get'

  match '/refresh_projects', :to => 'projects#refresh_projects', :via => 'get'
end
