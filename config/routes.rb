Rails.application.routes.draw do
  devise_for :users
  #ryon
  #ユーザーごとのカスタマイズを表示
  #scope module: :public do
    #"表示URL"=>"controller#action" で表示ページを記載
    #get "customers/mypage" => "customers#show"
    #get "customers/information/edit" => "customers#edit"
    #patch "customers/information" => "customers#update"
  #end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
