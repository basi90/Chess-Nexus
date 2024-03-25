Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :profiles do
    resources :friendships, only: [:create, :index]
  end

  resources :games, only: [:new, :show, :update_board] do
    resources :chatrooms, only: :show
  end

  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end

  post "update_board", to: "games#update_board"
end
