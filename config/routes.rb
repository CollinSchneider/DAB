Rails.application.routes.draw do


  get 'password_resets/new'

  get 'password_resets/edit'

  get '/view' => 'products#view'
  get '/sell' => 'affiliates#sell'

  get '/faq' => 'products#faq'
  get '/about' => 'products#about'
  get '/terms' => 'products#terms'
  get '/about-affiliates' => 'products#affiliates', as: :about_affiliates
  get '/about-shipping' => 'products#shipping', as: :about_shipping
  get '/contact' => 'products#contact'
  get '/returns' => 'products#returns'

  get '/profile' => 'users#profile'
  get '/profile/orders' => 'users#orders'
  get '/profile/addresses' => 'users#addresses'
  get '/shipping' => 'users#shipping'
  get '/account' => 'users#account'
  get '/signup' => 'users#signup'
  get '/password' => 'users#password'

  post '/charges' => 'charges#create'
  get '/best-sellers' => 'products#best_sellers'
  get '/new-arrivals' => 'products#new_arrivals'
  get '/featured' => 'products#featured'

  get '/cart' => 'users#cart'
  get '/tech' => 'products#tech'
  get '/apparel' => 'products#apparel'
  get '/gadgets' => 'products#gadgets'
  get '/art&culture' => 'products#art_culture'
  get '/essentials' => 'products#essentials'
  get '/accessories' => 'products#accessories'
  get '/user/support' => 'users#support'

  # Facebook Authentication
  get 'auth/:provider/callback', to: 'sessions#facebook_create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  # User Login/Signup
  post '/login' => 'sessions#create'
  post '/create' => 'users#create'

  resources :users do
    put 'update_account', :action => :update_account
    put 'update_password', :action => :update_password
  end
  resources :orders
  # resources :admins
    get '/admins' => 'admins#index'
    get '/admin-affiliates' => 'admins#affiliates'
    get '/admin-orders' => 'admins#orders'
    get '/admin-products' => 'admins#products'
    get '/admin-users' => 'admins#users'
    post '/admin-affiliate-order' => 'admins#update_affiliate_orders'
    get '/admin-editing' => 'admins#editing'

  # resources :affiliates
    get '/affiliate' => 'affiliates#index'
    get '/affiliate-orders' => 'affiliates#orders'
    get '/affiliate-update' => 'affiliates#update'
    get '/affiliate-products' => 'affiliates#products'


  resources :products
  resources :product_items
  resources :cart_items
  resources :order_items
  resources :charges
  resources :addresses
  resources :banners
  resources :password_resets,     only: [:new, :create, :edit, :update]
  # get '/reset_password' => 'users#reset_password', as: :password_reset
  # get '/reset_password/:token/edit' => 'users#new_password', as: :create_password_reset

  root 'users#index'

  post '/sessions' => 'sessions#create'
  delete '/sessions' => 'sessions#destroy'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
