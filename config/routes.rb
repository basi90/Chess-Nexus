Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :profiles do
    resources :friendships, only: [:create, :index]
  end

  resources :games, only: [:new, :show] do
    member do
      post :update_board
    end
    resources :chatrooms, only: :show
  end

  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end
end
