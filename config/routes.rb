Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: 'pages#welcome'
  resources :events, only: %i[index new create edit update destroy]

  resources :events, only: %i[show] do
    resources :invitations
    resources :slots, only: %i[show new create edit upvote update destroy]
  end

end
