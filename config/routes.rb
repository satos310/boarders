Rails.application.routes.draw do

  get 'relationships/create'
  get 'relationships/destroy'
  get 'relationships/following'
  get 'relationships/followers'
  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  root to: 'public/homes#top'

  namespace :admin do
    get 'homes/top' => 'homes#top'
    resources :genres, only: [:index, :create, :edit, :update]
    resources :users, only: [:index, :show, :edit, :update]
    resources :reviews, only: [:index, :show, :edit, :update]
  end

  scope module: :public do
    get 'homes/top'
    get 'homes/about'
    get 'customers/unsubscribe'
    patch 'customers/withdraw'
    resources :users, only: [:show, :edit, :update, :friends] do
      # フォロー機能はuserにネストさせている
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'favorites#followings', as: 'followings'
      get 'followers' => 'favorites#followers', as: 'followers'
    end

    resources :pickups, only: [:index]
    resources :reviews, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resources :pickups, only: [:create, :destroy]
      resources :stars, only: [:create, :destroy]
      get '/review/hashtag/:name' => 'reviews#hashtag'
      get '/review/hashtag' => 'reviews#hashtag'
      collection do
        get 'search'
      end
    end

    get "search_tag"=>"reviews#search_tag"
    resources :follows, only: [:create, :destroy]
    resources :notifications, only: [:index]
  end
end
