Rails.application.routes.draw do
  root 'home#index'
  get '/home/index_old' => 'home#index_old'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    post 'json_users', on: :collection
    post 'lottery', on: :collection
    get 'delete', on: :collection
    get 'active', on: :collection
  end

  resources :register

  resources :welcome

  resources :signin
  post '/register/upload_img' => 'register#upload_img'
end
