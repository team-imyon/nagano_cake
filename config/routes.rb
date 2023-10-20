Rails.application.routes.draw do

  root to: 'public/homes#top'
    get "/about" => "public/homes#about"

  scope module: :public do
    resources :items, only: [:index, :show]
  end

  #ユーザーごとのカスタマイズを表示
  scope module: :public do
    resources :customers, only: [:edit, :update]
    #"表示URL"=>"controller#action" で表示ページを記載
    get "customers/my_page" => "customers#show"
    get 'customers/quit' => "customers#quit"
    patch 'customers/withdraw' => 'customers#withdraw'
  end


  scope module: :public do
    resources :cart_items, only: [:index, :update, :destroy, :create]
    delete 'cart_items/all_destroy' => 'cart_items#all_destroy'
  end

  scope module: :public do
    resources :orders, only: [:new,  :create, :index, :show]
    post "orders/confirm" => "orders#confirm"
    get "orders/complete" => "orders#complete"
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

