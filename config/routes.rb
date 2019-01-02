Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  root 'welcome#index'

  get '/lottery/index' => 'lottery#index'
  get '/lottery/index_test' => 'lottery#index_test'
  get '/lottery/index_old' => 'lottery#index_old'
  get '/lottery/universe' => 'lottery#universe'
  get '/lottery/milky_way' => 'lottery#milky_way'
  get '/lottery/signin' => 'lottery#signin'
  get '/lottery/signin_test' => 'lottery#signin_test'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    post 'json_users', on: :collection
    post 'lottery', on: :collection
    get 'delete', on: :collection
    get 'active', on: :collection
    get 'reset', on: :collection
    post 'admin_create', on: :collection
  end

  resources :user_lists do
    get :import,         on: :collection
    post :upload, on: :collection
    get :import_preview, on: :collection
  end
  resources :register

  resources :user_requests
  resources :request_stats

  resources :welcome
  resources :draw
  resources :signin
  post '/register/upload_img' => 'register#upload_img'

  get '/home/qrcode' => 'home#qrcode'
  post '/home/upload_register' => 'home#upload_register'
  post '/home/upload_signin' => 'home#upload_signin'
end
