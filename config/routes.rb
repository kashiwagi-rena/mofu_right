Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "top#first_view"

  resources :posts, only: %i[index new create] do
    collection do
      get :greats
    end
  end
  resources :greats, only: %i[create destroy]
  resources :manifest, only: [:index]

  get '/privacy_policy', to: 'top#privacy_policy'  
end
