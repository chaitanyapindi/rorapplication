Rails.application.routes.draw do
  namespace :admin do
      resources :users
      resources :blogs
      resources :comments

      root to: "users#index"
    end
  get 'blogs/index'
  
  devise_for :users
  resources :blogs do 
    resources :comments
  end
  root 'blogs#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
