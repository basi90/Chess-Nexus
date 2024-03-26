Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :profiles do
    resources :friendships, only: [:create, :index]
  end

  resources :games, only: [:new, :show] do
    member do
      post :select_piece, :select_move
    end
    resources :chatrooms, only: :show
  end

  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end
end
