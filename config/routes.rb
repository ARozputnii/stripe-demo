Rails.application.routes.draw do
  root to: "home#index"

  devise_for :users
  resources :payments, only: :create
  mount StripeEvent::Engine, at: '/payments'
end
