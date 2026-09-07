Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  root "books#index"

  resources :books do
    resources :borrowings, only: [:create], shallow: true
  end

  resources :authors
  resources :categories

  resources :borrowings, only: [:index] do
    member do
      patch :return_book
    end
  end

  get "dashboard", to: "dashboard#index"

  get "up" => "rails/health#show", as: :rails_health_check
end
