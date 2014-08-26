ColaeleitoralWeb::Application.routes.draw do

  root :to => "home#index"
  
  get 'index', to: 'home#index'
  get 'estados', to: 'home#estados', as: 'estados'
  get 'partidos', to: 'home#partidos', as: 'partidos'
  get 'cola/:uf', to: 'home#cola', as: 'cola'
  get 'cola/:uf/:device_id', to: 'home#cola', as: 'cola_mobile'
  get 'edit/:id', to: 'home#edit', as: 'edit'
  get 'v/:id', to: 'home#view', as: 'view'
  get 'candidatos/:uf/:cargo_id', to: 'home#candidatos', as: 'candidatos'
  get 'candidatos/:uf/:cargo_id/:partido', to: 'home#candidatos', as: 'candidatos_partido'
  get 'roleta/:cola_id/:cargo/:partido', to: 'home#roleta', as: 'roleta'
  get 'avalia/:candidato_id/:cola_id/:cargo_id/:uf/:avaliacao/:partido', to: 'home#avalia', as: 'avalia'
  get 'remove/:cola_id/:cola_cargo_id/:candidato_id', to: 'home#remove', as: 'remove'
  get 'detalhe_candidato/:candidato_id', to: 'home#detalhe_candidato', as: 'detalhe_candidato'

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
