Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  get '/home' => 'videos#index', as: 'home'
  get '/' => 'static_pages#front',as:'front'
  get '/register' => 'users#new', as: 'register'
  get '/sign_in' => 'sessions#new', as: 'sign_in'
  get '/my_queue' => 'queue_items#index', as:'my_queue'
  get '/people', to: 'relationships#index', as: 'people'

  post '/my_queue' => 'queue_items#update_index'


  resources :users
  resources :queue_items, only: [:create, :destroy]
  resources :sessions, only: [:create, :destroy, :new]
  resources :relationships, only: [:destroy, :create]

  resources :videos do
    collection do
      get 'search'
    end
    resources :reviews
  end

  resources :categories
  resources :reviews
end
