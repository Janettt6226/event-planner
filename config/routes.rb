Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: 'pages#welcome'
  resources :events, only: %i[index new create edit update destroy]
  resources :users, only: %i[show] do
    resources :invitations, only: %i[index]
  end

  resources :events, only: %i[show] do
    resources :invitations, only: %i[new create edit update destroy]
    resources :suggestions, only: %i[show new create edit upvote update destroy]
  end

  get "calendar", to: "events#calendar", as: :calendar
end
