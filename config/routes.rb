Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'campaigns#index'

  resources :campaigns, only: [:new, :create, :show] do
    resources :pledges
  end

end
