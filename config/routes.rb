Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  root 'welcome#index'
  get '/activity_introduction' => 'welcome#activity_introduction'
  get '/research' => 'register#research_index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    post 'json_users', on: :collection
    post 'lottery', on: :collection
    get 'delete', on: :collection
    get 'active', on: :collection
    get 'reset', on: :collection
    post 'admin_create', on: :collection
    get 'research', on: :collection
  end

  resources :activitys do
    get 'delete', on: :collection
  end

  resources :user_lists do
    get :leader_index,   on: :collection
    get :import,         on: :collection
    post :upload, on: :collection
    get :import_preview, on: :collection
  end
  resources :register

  resources :user_requests
  resources :request_stats

  resources :welcome do
    get :scan_code,   on: :collection
  end
  resources :draw
  resources :signin
  post '/register/upload_img' => 'register#upload_img'

  get '/home/qrcode' => 'home#qrcode'
  post '/home/upload_register' => 'home#upload_register'
  post '/home/upload_signin' => 'home#upload_signin'

  resources :inventories do
    get :research, on: :collection
    get :import,         on: :collection
    post :upload, on: :collection
    get :import_preview, on: :collection
  end
end
