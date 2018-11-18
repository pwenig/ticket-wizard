# frozen_string_literal: true

Rails.application.routes.draw do
  root "pages#index"

  get "/signup",  to: "users#new"
  post "/signup",  to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#login"
  delete "/logout", to: "sessions#destroy"
  get "/create-event",  to: "events#new"
  post "/create-event",  to: "events#create"
  patch "/create-event",  to: "events#create"

  get 'auth/:provider/callback', to: 'sessions#create'

  resources :users do
    resources :comments
    member do
      get :attending
    end
  end

  resources :events do
    resources :comments
    resources :tickets
    resources :purchased_tickets, path: "get-tickets"
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
end
