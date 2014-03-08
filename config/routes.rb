HeisenBugDev::Application.routes.draw do
  root 'home#home'
  resources 'rasterizer', only: [:create]
end
