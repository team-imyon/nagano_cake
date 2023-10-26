Rails.application.routes.draw do

  root to: 'public/homes#top'
    get "/about" => "public/homes#about"

  scope module: :public do
    resources :items, only: [:index, :show]
  end

  #ユーザーごとのカスタマイズを表示
  scope module: :public do
    #"表示URL"=>"controller#action" で表示ページを記載
    get "customers/my_page" => "customers#show"
    get 'customers/quit' => "customers#quit"
    patch 'customers/withdraw' => 'customers#withdraw'
    resources :customers, only: [:edit, :update]
  end


  scope module: :public do
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items, only: [:index, :update, :destroy, :create]
  end


  scope module: :public do
    get "orders/complete" => "orders#complete"
    post "orders/confirm" => "orders#confirm"
    resources :orders, only: [:new,  :create, :index, :show]
  end

  scope module: :public do
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end



   get "/admin" => "admin/homes#top"

  namespace :admin do
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
  end


  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
  end

  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
  end


  namespace :admin do
    resources :orders, only: [:index, :show, :update]
  end

  get "/admin/orders/history/:id", to: "admin/orders#index", as: "history"

  namespace :admin do
    resources :order_details, only: [:update]
  end


  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }


  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {

    sessions: "admin/sessions"
  }

end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

