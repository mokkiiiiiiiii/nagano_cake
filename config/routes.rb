Rails.application.routes.draw do
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
 }

 namespace :public do
   root to: 'homes#top'
   get "home/about" => "homes#about", as: "about"
   delete "/cart_items/destroy_all"
   patch "/customers/withdraw"
   get "/customers/show"
   post "/orders/check"
   get "/orders/complete"

    resources :items, only: [:index,:show]
    resources :customers, only: [:edit,:update]
    resources :cart_items, only:[:index,:update,:destroy,:create]
    resources :orders, only: [:new,:create,:index,:show]
    resources :addresses, only:[:index,:edit,:create,:update,:destroy]
    resources :cart_items
    end

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

   namespace :admin do
   root to: 'homes#top'

    resources :items, only: [:new,:index,:show,:create,:edit,:update]
    resources :genres, only: [:index,:create,:edit,:update]
    resources :customers, only: [:index,:show,:edit,:update]
    resources :orders, only: [:show,:update]
    resources :order_details, only:[:update]
 end

end
