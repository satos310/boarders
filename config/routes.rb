Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  root to: 'public/homes#top'

  namespace :admin do
    get 'homes/top' => 'homes#top'
    resources :genres, only: [:index, :create, :edit, :update]
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :reviews, only: [:index, :show, :destroy]
    get "search_tag"=>"reviews#search_tag"
  end

  scope module: :public do
    get 'homes/top'
    get 'homes/about'

    resources :reviews, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resources :pickups, only: [:create, :destroy]
      resources :stars, only: [:create, :destroy]
      get '/review/hashtag/:name' => 'reviews#hashtag'
      get '/review/hashtag' => 'reviews#hashtag'
      resources :comments, only: [:create, :destroy]
      collection do
        get 'search'
      end
    end

    resources :users, only: [:show, :edit, :update, :friends, :destroy] do
      get 'unsubscribe'
      member do
        get :pickups
      end
      get 'friends'
      # フォロー機能はuserにネストさせている
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end

    get "search_tag"=>"reviews#search_tag"
    resources :follows, only: [:create, :destroy]
    resources :notifications, only: [:index]
  end
end
