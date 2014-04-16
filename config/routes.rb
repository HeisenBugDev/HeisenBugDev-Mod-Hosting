HeisenBugDev::Application.routes.draw do
  root 'home#home'

  namespace :users do
    put 'update_token', :to => 'token#update'
  end

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

  resources 'projects' do
    scope :module => :wiki do
      resources 'wikis' do
        resources 'articles'
      end
      get ':id/refresh_wiki', :to => 'wikis#update_wiki', :as => :refresh_wiki
    end
  end

  match '/downloads', :to => 'builds#index', :via => 'get'
end
