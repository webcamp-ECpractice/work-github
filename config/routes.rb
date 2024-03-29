Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'

    resources :items, only: [:index, :show]

    get 'customers/my_page'=> 'customers#show'
    get 'customers/information/edit' =>'customers#edit'
    patch 'customers' => 'customers#update'
    get 'customers/confirm' => 'customers#confirm'
    patch 'customers/withdrawal' => 'customers#withdrawal'

    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items, only: [:index,:update,:create,:destroy]

    get 'orders/complete' => 'orders#complete'
    resources :orders, only: [:new,:create,:update,:index,:show]
    post 'orders/confirm_orders' => 'orders#confirm_orders'


    resources :addresses, only: [:create,:index,:edit,:update,:destroy]
  end

  namespace :admin do
    get '/' => 'homes#top'

    resources :items, except: [:destroy]
    resources :genres, only: [:create,:index,:edit,:update]
    resources :customers, only: [:index,:show,:edit,:update]
    resources :orders, only: [:update,:show]
    get 'orders/customer_order/:id' => 'orders#customer_order' ,as: :customer_order
    resources :order_details, only: [:update]
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }


  devise_for :customers, skip:[:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

end