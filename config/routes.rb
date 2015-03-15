Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  get '/home' => 'videos#index'
  get '/' => 'videos#index'
  get '/front' => 'static_pages#front'
  get '/register' => 'users#new', as: 'register'

  resources :users do
  end

  resources :videos do
    collection do
      get 'search'
    end
  end
  resources :categories
end
