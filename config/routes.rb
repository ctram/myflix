Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  get '/home' => 'videos#index', as: 'home'
  get '/' => 'static_pages#front', as:'front'
  get '/register' => 'users#new', as: 'register'
  get '/sign-in' => 'sessions#new', as: 'sign_in'
  get '/my_queue' => 'queues#show'

  resources :users do
  end

  resources :sessions, only: [:create, :destroy, :new]

  resources :videos do
    collection do
      get 'search'
    end
    resources :reviews
  end

  resources :categories
  resources :reviews
end
