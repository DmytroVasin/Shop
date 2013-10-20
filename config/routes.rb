Shop::Application.routes.draw do
  resources :ratings, only: [:create]

  resources :orders
  resources :carts

  resources :line_items do
    put 'decrease', on: :member
    put 'increase', on: :member
  end


  root to: 'welcome#index'

  devise_for :admins, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout' }, controllers: { sessions: 'sessions' }


  namespace :admin do
    root :to => 'base#index'

    resources :products
    resources :categories
    resources :brands
    resources :orders
    resources :parsers, only: [:index] do
      post 'get_product', on: :collection
    end
  end

  resources :products

  match 'about_us' => 'optional_pages#about_us'
  match 'to_order' => 'optional_pages#to_order'
  match 'warranties' => 'optional_pages#warranties'
  match 'service' => 'optional_pages#service'
  match 'faqs' => 'optional_pages#faqs'
  match 'security' => 'optional_pages#security'
  match 'policy' => 'optional_pages#policy'
  match 'delay_prodcuts' => 'optional_pages#delay_prodcuts'
  match 'delivery' => 'optional_pages#delivery'
  match 'another' => 'optional_pages#another'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
