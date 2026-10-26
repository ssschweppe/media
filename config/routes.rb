Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  get "about", to: "pages#about"

  # Публичная часть: только опубликованные посты, адрес по slug — /posts/<slug>
  resources :posts, only: %i[ index show ], param: :slug

  # Админка: все посты и CRUD, доступ только у администратора (Admin::BaseController)
  namespace :admin do
    root "dashboard#index"
    resources :rubrics
    resources :categories
    resources :posts
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
