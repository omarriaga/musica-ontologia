Rails.application.routes.draw do
  root 'home#index'

  get 'instancias/:clase' => 'home#instancias', as: :instancias
  get 'show/:instancias' => 'home#show', as: :show

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
