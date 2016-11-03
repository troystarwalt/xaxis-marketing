Rails.application.routes.draw do

  get 'value-calculator' => "landing_pages#value_calculator", as: :value_calculator
  get 'expert-interview-hub' => "landing_pages#expert_interview_hub", as: :expert_interview_hub


  get 'presentation_hub', to: 'presentation_hub#index', as: :presentation_hub
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

  get '404' => 'errors#four_oh_four', as: :error_404
  get "*detail" => 'application#catch_not_found'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
