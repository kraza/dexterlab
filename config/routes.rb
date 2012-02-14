Dexterlab::Application.routes.draw do
  #get "reports/index"

  get "reports/patient"

  get "reports/testvspatient"

  get "reports/doctorvstest"

  get "reports/doctorvspatient"

  require File.expand_path("../../lib/logged_in_constraint", __FILE__)

  #  put "user_informations/:id" => "user_informations/update"
  #resources :user_informations, :only => [:update]
  
  match  "account" => "user_informations#update", :via => :post
  match  "account" => "user_informations#edit"#, : => :get
  #get "user_informations/:id/edit", :as => 'account'
  #match "user_informations/edit" => "account"
  resources :tests

  resources :reports, :only => :index

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
      get 'prescription_print'
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

  #get "welcome/index"

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
  root :to => "welcome#index", :constraints => LoggedInConstraint.new(false)
  root :to => "welcome#home", :constraints => LoggedInConstraint.new(true)

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
  #Temporary fix for routing error. once rescue_from ActionController::RoutingError will fix in rails 3.
  #then remove below line
  match '*path', :to => 'welcome#index'
end
