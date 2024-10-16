Rails.application.routes.draw do
  root 'home#index'

  devise_for :users
  
  resources :rooms do
    collection do
      get 'my_rooms'
    end
  end

  resources :reservations, only: [:new, :create, :show, :index, :destroy]
  resource :account, only: [:show, :edit, :update]
end
