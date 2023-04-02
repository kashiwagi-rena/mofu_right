Rails.application.routes.draw do
  get 'static_pages/before_login'
  get 'static_pages/after_login'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "top#first_view"
  get '/before_login', to: 'static_pages#before_login'
  post '/after_login', to: 'static_pages#after_login'

  resources :posts, only: %i[index new create]
end
