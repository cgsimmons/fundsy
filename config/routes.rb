Rails.application.routes.draw do
  resources :campaigns, only: [:new, :create, :show] do
    resources :pledges, only: :create
    resources :publishings, only: :create
  end
  root 'campaigns#index'
end
