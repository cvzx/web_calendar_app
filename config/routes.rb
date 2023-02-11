# frozen_string_literal: true

Rails.application.routes.draw do
  post 'auth/login'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'appointments#index'

  resources :appointments
end
