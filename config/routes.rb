Rails.application.routes.draw do
  root to: "home#index"

  post "payment", to: "payments#create"
  devise_for :users
  mount StripeEvent::Engine, at: '/payments'
end
