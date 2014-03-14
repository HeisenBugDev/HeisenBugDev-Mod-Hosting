HeisenBugDev::Application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root 'home#home'
  resources 'rasterizer', :only => [:create]
  resources 'artifacts',  :only => [:create]
  resources 'projects',   :only => [:update]

  match '/', :to => 'projects#refresh_projects', :via => 'get'
end
