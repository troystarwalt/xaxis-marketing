Rails.application.routes.draw do

  get 'tags/:tag', to: 'posts#index', as: :tag
  resources :posts

  root :to => 'posts#main'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
