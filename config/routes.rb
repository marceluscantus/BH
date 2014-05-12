BH::Application.routes.draw do

  root :to => 'catalog#index'

  match 'catalog' => 'catalog#index'
  match 'admin/glasses' => 'admin/glasses#index'
  match 'about' => 'about#index'  
  match 'checkout' => 'checkout#index'
  match 'admin/manufacturer' => 'admin/manufacturer#index'
  match 'admin/order' => 'admin/order#index'

  get 'admin/manufacturer/new'
  post 'admin/manufacturer/create'
  get 'admin/manufacturer/edit'
  post 'admin/manufacturer/update'
  post 'admin/manufacturer/destroy'
  get 'admin/manufacturer/show'
  match 'admin/manufacturer/show/:id' => 'admin/manufacturer#show'
  get 'admin/manufacturer/index'

  get 'admin/glasses/new'
  post 'admin/glasses/create'
  get 'admin/glasses/edit'
  post 'admin/glasses/update'
  post 'admin/glasses/destroy'
  get 'admin/glasses/show'
  match 'admin/glasses/show/:id' => 'admin/glasses#show'
  get 'admin/glasses/index'
  
  get 'catalog/show'
  match 'catalog/show/:id' => 'catalog#show'
  get 'catalog/index'
  get 'catalog/latest'
  get 'catalog/search'
  match 'catalog/search/:q' => 'catalog/search#search'
  
  get 'cart/add'
  post 'cart/add'
  get 'cart/remove'
  post 'cart/remove'
  get 'cart/clear'
  post 'cart/clear'
  
  post 'admin/order/close'
  get 'admin/order/show'
  match 'admin/order/show/:id' => 'admin/order#show'
  get 'admin/order/index'
  post 'admin/order/destroy'

  get 'checkout/index'
  post 'checkout/submit_order'
  get 'checkout/thank_you'

  get 'user_session/new'
  post 'user_session/create'
  get 'user_session/destroy'

  get 'user/new'
  post 'user/create'
  get 'user/show'
  match 'user/show/:id' => 'user#show'
  get 'user/edit'
  post 'user/update'
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   

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
  #     resources :manufacturer
  #   end
end
