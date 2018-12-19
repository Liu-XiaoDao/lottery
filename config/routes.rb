Rails.application.routes.draw do
  root 'welcome#index'

  get '/home/index' => 'home#index'
  get '/home/index_old' => 'home#index_old'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    post 'json_users', on: :collection
    post 'lottery', on: :collection
    get 'delete', on: :collection
    get 'active', on: :collection
  end

  resources :user_lists do
    get :import,         on: :collection
    post :upload, on: :collection
    get :import_preview, on: :collection
  end
  resources :register

  resources :welcome
  resources :draw
  resources :signin
  post '/register/upload_img' => 'register#upload_img'
end
