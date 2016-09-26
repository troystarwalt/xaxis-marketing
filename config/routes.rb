Rails.application.routes.draw do

  get 'logos/new'

  get 'logos/create'

  get 'logos/delete'

  resources :brands, path: :brand_assets
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'posts/:tag', to: 'posts#index', as: :tag
  resources :posts

  root :to => 'posts#main'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
