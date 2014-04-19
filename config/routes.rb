Shop::Application.routes.draw do
  root to: 'welcome#index'

  resources :orders
  resources :ratings, only: [:create]
  resources :carts, only: [:show, :destroy]

  resources :line_items do
    put 'decrease', on: :member
    put 'increase', on: :member
  end

  devise_for :admins, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout' }, controllers: { sessions: 'sessions' }

  namespace :admin do
    root :to => 'base#index'

    resources :products do
      post 'best_sell', on: :collection
      post 'update_features', on: :collection
    end
    resources :categories
    resources :brands
    resources :colours do
      post 'update_common_colour', on: :collection
    end
    resources :orders
    resources :images,  only: [:destroy]
    resources :parsers, only: [:index] do
      post 'get_product', on: :collection
    end
  end

  resources :products do
    get 'color_picker', on: :collection
  end

  resources :reviews

  match 'about_us', to: 'optional_pages#about_us', via: :get
  match 'to_order', to: 'optional_pages#to_order', via: :get
  match 'warranties', to: 'optional_pages#warranties', via: :get
  match 'faqs', to: 'optional_pages#faqs', via: :get
  match 'security', to: 'optional_pages#security', via: :get
  match 'policy', to: 'optional_pages#policy', via: :get
  match 'delivery', to: 'optional_pages#delivery', via: :get
  match 'action', to: 'optional_pages#action', via: :get
  match 'contacts', to: 'optional_pages#contacts', via: :get
  match 'materials', to: 'optional_pages#materials', via: :get

  match 'contacts_call', to: 'optional_pages#contacts_call', via: :post
end
