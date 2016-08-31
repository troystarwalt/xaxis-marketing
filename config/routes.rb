Rails.application.routes.draw do
  get 'updates/index' => 'updates#index'

  get 'updates/new' => 'updates#new'

  get 'updates/create' => 'updates#create'

  get 'updates/destroy' => 'updates#destroy'

  root :to => 'updates#main'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
