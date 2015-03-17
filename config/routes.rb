Rails.application.routes.draw do
  
  resources :filters

  get '/galleries/share', to: 'galleries#shared_gallery', as: '/galleries/share'
  get '/filters/image/:image_id/', to: 'filters#editimage', as: 'filters/editimage'
  get '/filters/apply/:image_id', to: 'filters#apply', as: 'filters/apply'
  get '/images/:id', to: 'images#versionIndex',as:'images_version'
  post '/images/select/', to: 'images#select', as: 'images/select'
  post '/share', to: 'images#share', as: 'share'
  post '/gallery/:gallery_id/image/:image_id/option/:option' => 'filters#addTo', as: :add_filter_to

  get '/images/trash/new', to: 'images#trashIndex' ,as: 'images/trash/new'
  post '/images/emptytrash', to: 'images#emptytrash' ,as: 'images/emptytrash'

  

  post '/images/trash/:id/restore', to: 'images#restore', as: 'restore'

  devise_for :users

  resources :galleries do
    resources :images
  end


  root to:"galleries#index"

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
