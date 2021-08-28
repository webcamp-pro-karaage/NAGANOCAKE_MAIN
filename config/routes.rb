Rails.application.routes.draw do

  devise_for :admin, controllers: {
    sessions: 'admin/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

#管理者側
namespace :admin do
  root :to => 'homes#top'
  resources :items, except: [:destroy]
  resources :genres, only: [:index, :create, :edit, :update]
  resources :customers, only: [:index, :show, :edit, :update]
  resources :orders, only: [:show, :update]
  resources :ordered_items, only: [:update]
  end

#会員側
scope module: :public do
  root :to => 'homes#top'
  get '/about' => 'homes#about'
  resources :items, only: [:index, :show]
  resource :customer, only: [:show, :edit, :update]
  patch 'customer/unsubscribe' => 'customers#unsubscribe'
  get 'customer/withdraw' => 'customers#withdraw'
  resources :cart_items, only: [:index, :create, :update, :destroy]
  delete 'cart_item/destroy_all' => 'cart_items#destroy_all'
  resources :orders, only: [:new, :create, :index, :show]
  post 'order/confirm' => 'orders#confirm'
  get 'order/complete' => 'orders#complete'
  resources :addresses, except: [:new, :show]
  devise_for :customers, controllers: {
    sessions: 'public/customers/sessions',
    registrations: 'public/customers/registrations'
  }
  end

end
