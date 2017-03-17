# frozen_string_literal: true
Rails.application.routes.draw do

  resources :contacts, only: [:new, :create]

  get 'value-calculator' => "landing_pages#value_calculator", as: :value_calculator
  get 'expert-interview-hub' => "landing_pages#expert_interview_hub", as: :expert_interview_hub
  get '101-series' => "landing_pages#one_oh_one_series", as: :one_oh_one_series
  get 'groupm-signature' => "landing_pages#group_m_signature", as: :groupm_sig
  get 'xaxis-signature' => "landing_pages#xaxis_signature", as: :xaxis_sig
  get 'smart-kapp' => "landing_pages#smart_kapp"
  get 'all-hands' => "landing_pages#all_hands"

  get 'presentation_hub', to: 'presentation_hub#index', as: :presentation_hub
  get "case-studies/search" => "case_studies#search", as: :case_studies_search

  get "/pages/:page" => "landing_pages#show"

  # Hiding case studies for now.
  # resources :case_studies, path: :'case-studies', only: [:index, :show]

  resources :brands, path: :brand_assets, only: [:index, :show]

  # Hiding platform routes for now.

  # resources :platforms, only: [:show] do
  #   resources :case_studies, path: :'case-studies', only: [:index]
  # end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :posts, only: [:show, :index, :main]
  get 'tags/:tag', to: 'posts#index', as: :tag
  root :to => 'posts#main'

  get '404' => 'errors#four_oh_four', as: :error_404
  get "*detail" => 'application#catch_not_found'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
