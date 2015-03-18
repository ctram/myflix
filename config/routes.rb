Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  get '/home' => 'videos#index'
  get '/' => 'videos#index'
  get '/front' => 'static_pages#front'
  get '/register' => 'users#new', as: 'register'
  get '/sign-in' => 'sessions#new', as: 'sign-in'

  resources :users do
  end

  resources :sessions, only: [:create]

  resources :videos do
    collection do
      get 'search'
    end
  end
  resources :categories
end
