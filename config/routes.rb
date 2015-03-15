Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  get '/home' => 'videos#index'
  get '/' => 'videos#index'

  resources :videos
  resources :categories
end
