require 'sidekiq/web'

Gratifiled::Application.routes.draw do
  root :to => "home#show"

  resource :home, only: :show
  resources :documents, only: [:new, :create] do
    get "confirmation", to: "confirmations#show", as: "confirmation"
  end
  get "/documents/:uuid" => "documents#show", :as => "document"

  mount Sidekiq::Web, at: '/sidekiq'
end
