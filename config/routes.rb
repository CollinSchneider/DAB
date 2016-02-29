Rails.application.routes.draw do


  get '/view' => 'products#view'
  get '/sell' => 'affiliates#sell'

  get '/faq' => 'products#faq'
  get '/about' => 'products#about'
  get '/terms' => 'products#terms'
  get '/about-affiliates' => 'products#affiliates', as: :about_affiliates
  get '/shipping' => 'products#shipping'
  get '/contact' => 'products#contact'

  get '/affiliate' => 'users#affiliate'

  get '/cart' => 'users#cart'

  namespace :api do
    resources :products
    resources :inventories
  end

  resources :users
  resources :orders
  resources :admins
  resources :affiliates
  resources :products
  resources :cart_items

  root 'products#index'

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
