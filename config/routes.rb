Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "users/registrations"}
  root "static_pages#home"

  namespace :admin do
    root "subjects#index"
    resources :subjects
  end
end
