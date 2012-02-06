Dexterlab::Application.routes.draw do
  resources :tests

  #patients_list_doctors GET /doctors
  resources :doctors do
    member  do
       get 'patients_list'
       get 'account'
       get 'payment'
       get 'export_to_csv'
       post 'make_payment'
    end

  end

  resources :patients do
      member do
      get 'add_test'
      delete 'remove_test'
      end
    end
  #tests_test_category GET    /test_categories/:id/tests(.:format) {:action=>"tests", :controller=>"test_categories"}
  # Get the list of all tests related to that specific test category.
  resources :test_categories do
    member do
      get 'tests'
    end

  end

  get "welcome/index"

  devise_for :users

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
  #
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
   root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
  #Temporary fix for routing error. once rescue_from ActionController::RoutingError will fix in rails 3.
  #then remove below line
  match '*path', :to => 'welcome#index'
end
