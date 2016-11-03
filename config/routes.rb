Rails.application.routes.draw do

  get 'presentation_hub', to: 'presentation_hub#index', as: :presentation_hub

  # get 'logos/new'
  #
  # get 'logos/create'
  #
  # get 'logos/delete'
  get "case-studies/search" => "case_studies#search", as: :case_studies_search
  resources :case_studies, path: :'case-studies', only: [:index, :show]
  resources :brands, path: :brand_assets, only: [:index, :show]
  resources :platforms, only: [:show] do
    resources :case_studies, path: :'case-studies', only: [:index]
  end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :posts
  get 'tags/:tag', to: 'posts#index', as: :tag
  root :to => 'posts#main'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
