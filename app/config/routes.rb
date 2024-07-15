Rails.application.routes.draw do
  resources :categories, except: :show
  resources :products
  root to: "products#index"
  
  namespace :authentication do 
    resources :users, only: [:new, :create]
  end

end
