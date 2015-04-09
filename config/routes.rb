Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  get '/home' => 'videos#index', as: 'home'
  get '/' => 'static_pages#front',as:'front'
  get '/register' => 'users#new', as: 'register'
  get '/sign_in' => 'sessions#new', as: 'sign_in'
  get '/my_queue' => 'queue_items#index', as:'my_queue'
  get '/people', to: 'relationships#index', as: 'people'
  get 'forgot_password', to: 'forgot_passwords#new'
  get 'forgot_password_confirmation', to: 'forgot_passwords#confirm'
  get 'expired_token', to: 'password_resets#expired_token'

  post '/my_queue' => 'queue_items#update_index'

  resources :invitations, only:[:new, :create]
  resources :password_resets, only: [:show, :create]
  resources :forgot_passwords, only: [:create]
  resources :users
  resources :queue_items, only: [:create, :destroy]
  resources :sessions, only: [:create, :destroy, :new]
  resources :relationships, only: [:destroy, :create]
  resources :categories
  resources :reviews

  resources :videos do
    collection do
      get 'search'
    end
    resources :reviews
  end

end
