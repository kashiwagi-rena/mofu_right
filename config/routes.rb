Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "top#first_view"

  resources :posts, only: %i[index new create show] do
    resources :comments, only: %i[create], shallow: true
    collection do
      get :greats
    end
  end
  resources :greats, only: %i[create destroy]

  get '/privacy_policy', to: 'top#privacy_policy'  
end
