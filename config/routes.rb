Rails.application.routes.draw do
  get 'hello_world', to: 'hello_world#index'
  root 'access#login'
  resources :seasons do
    resources :games
    resources :players
  end
  match ':controller(/:action(/:id))', :via => [:get, :post]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
