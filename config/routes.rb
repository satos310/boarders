Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get 'homes/top'
    resources :genres, only: [:index, :create, :edit, :update]
    resources :users, only: [:index, :show, :edit, :update]
    resources :reviews, only: [:index, :show, :edit, :update]
  end

  scope module: :public do
    get 'homes/top'
    get 'homes/about'
    get 'customers/unsubscribe'
    patch 'customers/withdraw'
    resources :users, only: [:show, :edit, :update]
    resources :reviews, only: [:new, :create, :index, :show, :edit, :update]
    resources :pickups, only: [:create, :destroy]
    resources :follows, only: [:create, :destroy]
  end
end
