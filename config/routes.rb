HeisenBugDev::Application.routes.draw do
  devise_for :users
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root 'home#home'
  resources 'rasterizer', :only => [:create]
  resources 'artifacts',  :only => [:create]
  resources 'builds',     :only => [:create]

  match '/downloads', :to => 'builds#downloads', :via => 'get'

  match '/refresh_projects', :to => 'projects#refresh_projects', :via => 'get'
end
