Gratifiled::Application.routes.draw do
  root :to => "home#show"

  resource :home, only: :show
  resources :files
end
