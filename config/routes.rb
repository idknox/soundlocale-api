Rails.application.routes.draw do
  scope path: :api do
    resources :events, only: [:index]
  end
end
