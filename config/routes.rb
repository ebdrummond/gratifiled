require 'sidekiq/web'

Gratifiled::Application.routes.draw do
  root :to => "home#show"

  resource :home, only: :show
  resources :documents do
    get "confirmation", to: "confirmations#show", as: "confirmation"
  end

  mount Sidekiq::Web, at: '/sidekiq'
end
