Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"}

  root "static_pages#home"

  resources :users
  resources :exams, except: [:destroy]
  resources :questions, only: [:new, :index, :create, :destroy]

  namespace :admin do
    root "subjects#index"
    resources :subjects
    resources :questions
    resources :users
  end
end
