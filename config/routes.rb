HeisenBugDev::Application.routes.draw do
  constraints subdomain: 'www' do
    get ':any', to: redirect(subdomain: nil, path: '/%{any}'), any: /.*/
  end

  root 'ember#index'

  scope :api, defaults: { format: 'json' }, constraints: { format: 'json' } do
    namespace :users do
      put 'update_token', to: 'token#update'
    end

    #:controllers =>
   # { :omniauth_callbacks => "users/omniauth_callbacks",
   #   :sessions => :sessions },

    devise_for :users, only: []
    devise_scope :user do
      post 'sign_in'  => 'sessions#create'
      delete 'sign_out' => 'sessions#destroy'
    end
      # get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
      # delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session

    resources 'users'

    scope module: :wiki do
      resources 'wikis'
    end

    namespace :projects do
      delete :remove_user
    end

    resources 'rasterizer', only: [:create]
    resources 'versions',   only: [:show]
    resources 'flashes',    only: [:index]

    resources 'builds', only: [:create, :index, :show]

    get '/documentation', to: 'documentation#index'
    get '/documentation/:id', to: 'documentation#show', as: :documentation_show
    post '/builds/:id', to: 'builds#artifact_upload', as: :artifact_upload

    resources 'projects' do
      resources 'builds', except: [:create] do
        resources 'artifacts', only: [] do
          get 'download', to: 'builds#download', as: :download
        end

        get 'download', to: 'builds#download', as: :download
      end
      get 'download', to: 'builds#download', as: :download
      get :downloads
    end
  end
  get '*path', to: 'ember#index'
end
