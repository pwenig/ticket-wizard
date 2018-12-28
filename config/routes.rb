# frozen_string_literal: true

Rails.application.routes.draw do
  root "pages#index"

  get "/signup",  to: "users#new"
  post "/signup",  to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#login"
  delete "/logout", to: "sessions#destroy"
  get '/logout', to: 'sessions#destroy'

  get 'auth/:provider/callback', to: 'sessions#create'

  resources :users do
    resources :comments
    member do
      get :attending
    end
  end

  resources :events do
    resources :comments
    resources :tickets, except: [:show]
    resources :purchased_tickets, path: "get-tickets"
    resources :dashboard, only: [:index]
    resources :orders, only: [:index, :show]
    get '/user_order', to: 'orders#customer_order'
    get '/guest_list', to: 'orders#guest_list'
    get '/add_guest', to: 'orders#add_guest'
    post '/new_guest', to: 'orders#new_guest'

    member do
      get :attendees
    end
  end

  resources :users, only: [:show, :edit]
  resources :events
  resources :attends, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
  resources :charges
  post "/charges/new", to: "charges#calculate"

  match '*path' => 'pages#index', via: :all
end
