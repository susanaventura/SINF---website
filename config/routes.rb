Rails.application.routes.draw do
  root 'static_pages#home'
  resources :users, except:[:edit]
  resources :images, path: 'pri_images'

  get 'register' => 'users#new'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get 'home' => 'static_pages#home'
  get 'products' => 'static_pages#products'
  get 'stores' => 'static_pages#stores_index'
  get 'product' => 'static_pages#product'

  get 'checkout/overview', to: 'orders#checkout_overview', as: 'checkout_overview'
  get 'checkout/preview', to: 'orders#checkout_preview', as: 'checkout_preview'


  get 'users/editaccount/:id' => 'users#edit_account', as: 'edit_account'
  get 'users/editaddress/:id' => 'users#edit_address', as: 'edit_address'

  post 'cart/add', to: 'shopping_carts#add_item', as: 'cart_add'
  post 'cart/remove', to: 'shopping_carts#remove_item', as: 'cart_remove'
  post 'cart/update', to: 'shopping_carts#update', as: 'cart_update'
  get 'cart/clear', to: 'shopping_carts#clear', as: 'cart_clear'


  get 'cart/test', to: 'shopping_carts#test', as: 'cart_test'

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
