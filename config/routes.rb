Rails.application.routes.draw do
  resources :repositories
  root to: "repositories#index"
  resources :repositories do
    resources :file_uploads, only: [:new, :create]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
