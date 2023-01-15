Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root to: "homes#top"
    resources :items,         only: [:new, :create, :index, :show, :edit, :update]
    resources :genres,        only: [:index, :create, :edit, :update]
    resources :customers,     only: [:index, :show, :edit, :update]
    resources :orders,        only: [:show, :update]
    resources :order_details, only: [:update]
  end

  scope module: :public do
    root to: "homes#top"

    resources :items,      only: [:index, :show]

    resource :customers,  only: [:show, :edit, :update]
    get    'unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    patch  'withdrawal'  => 'customers#withdrawal', as: 'withdrawal'

    resources :cart_items, only: [:create, :index, :update, :destroy]
    delete 'destroy_all' => 'cart_items#destroy_all'

    resources :orders,     only: [:new, :create, :index, :show]
    post   'confirm'     => 'orders#confirm'
    get    'complete'    => 'orders#complete'

    resources :addresses,  only: [:create, :index, :edit, :update, :destroy]

    get "/about" => "homes#about", as: "about"
  end

  devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
