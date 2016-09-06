Rails.application.routes.draw do

  resources :updates

  root :to => 'updates#main'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
