Rails.application.routes.draw do
  root to: "home#index"

  get "show", to: "home#show"
  get "repeat_payment", to: "home#repeat_payment"
  post "payment", to: "payments#create"
  devise_for :users
  mount StripeEvent::Engine, at: "/payments"
end
