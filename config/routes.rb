Rails.application.routes.draw do


  get '/view' => 'products#view'
  get '/sell' => 'affiliates#sell'

  get '/faq' => 'products#faq'
  get '/about' => 'products#about'
  get '/terms' => 'products#terms'
  get '/about-affiliates' => 'products#affiliates', as: :about_affiliates
  get '/about-shipping' => 'products#shipping', as: :about_shipping
  get '/contact' => 'products#contact'

  get '/affiliate' => 'users#affiliate'
  get '/profile' => 'users#profile'
  get '/profile/orders' => 'users#orders'
  get '/profile/addresses' => 'users#addresses'
  get '/shipping' => 'users#shipping'
  get '/account' => 'users#account'
  get '/signup' => 'users#signup'

  get '/best-sellers' => 'products#best_sellers'
  get '/new-arrivals' => 'products#new_arrivals'

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

  resources :users
  resources :orders
  resources :admins
    get '/admin-affiliates' => 'admins#affiliates'
    get '/admin-orders' => 'admins#orders'
    get '/admin-products' => 'admins#products'
    get '/admin-users' => 'admins#users'

  resources :affiliates
  resources :products
  resources :product_items
  resources :cart_items
  resources :order_items
  resources :charges
  resources :addresses

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
