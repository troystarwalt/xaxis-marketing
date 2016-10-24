Rails.application.routes.draw do

  get 'case_studies/index'

  get 'case_studies/show'

  get 'presentation_hub', to: 'presentation_hub#index', as: :presentation_hub

  # get 'logos/new'
  #
  # get 'logos/create'
  #
  # get 'logos/delete'
  resources :case_studies, path: :'case-studies', only: [:index, :show]
  resources :brands, path: :brand_assets, only: [:index, :show]
  resources :platforms, only: [:index, :show]
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :posts
  get 'tags/:tag', to: 'posts#index', as: :tag
  root :to => 'posts#main'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
