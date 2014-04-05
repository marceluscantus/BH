BH::Application.routes.draw do

  match 'admin/manufacturer' => 'admin/manufacturer#index'
  
  get "admin/manufacturer/new"
  post "admin/manufacturer/create"
  get "admin/manufacturer/edit"
  post "admin/manufacturer/update"
  post "admin/manufacturer/destroy"
  get "admin/manufacturer/show"
  match 'admin/manufacturer/show/:id' => 'admin/manufacturer#show'
  get "admin/manufacturer/index"
  get 'admin/manufacturer/index'

  get "about/index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root :to => 'about#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  
  #Redirect About
  match 'about' => 'about#index'


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
     namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
       resources :manufacturer
     end
end
