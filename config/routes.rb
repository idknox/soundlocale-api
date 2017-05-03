Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, controllers: {sessions: 'api/sessions', registrations: 'api/registrations'}

  root to: 'api/sessions#new'

  namespace :api do
    get 'me', to: 'users#me'
    resources :events, only: [:index]
  end
end
