Rails.application.routes.draw do

  root 'dashboard#home'

  get "/update-time-widget/:id" => "dashboard#update_time_widget"

  get '/team/:uid' => "teams#dashboard", as: :dashboard

  get '/team/:uid/module_before' => "teams#module_before", as: :module_before_team
  get '/team/:uid/module_survival' => "teams#module_survival", as: :module_survival_team
  get '/team/:uid/module_race' => "teams#module_race", as: :module_race_team
  get '/team/:uid/module_results' => "teams#module_results", as: :module_results_team

  get '/team/:uid/before_rules_start' => "teams#before_rules_start", as: :before_rules_start_team
  post '/team/:uid/before_rules_start' => "teams#before_rules_go"
  get '/team/:uid/before_rules_questions' => "teams#before_rules_questions", as: :before_rules_questions_team
  post '/team/:uid/before_rules_questions' => "teams#before_rules_questions"
  get '/team/:uid/before_rules_done' => "teams#before_rules_done", as: :before_rules_done_team
  get '/team/:uid/before_rules_expired' => "teams#before_rules_expired", as: :before_rules_expired_team

  get '/team/:uid/before_register_start' => "teams#before_register_start", as: :before_register_start_team

  post '/team/:uid/before_about_upload' => "teams#before_about_upload", as: :before_about_upload_team
  get '/team/:uid/before_about_ok' => "teams#before_about_ok", as: :before_about_ok_team
  get '/team/:uid/before_about_failed' => "teams#before_about_failed", as: :before_about_failed_team

  # get '/team/:uid/choose_transport' => "teams#choose_transport"
  # post '/team/:uid/choose_transport' => "teams#choose_transport_submit"
  #
  # get '/team/:uid/rule_test' => "teams#rule_test"
  # post '/team/:uid/rule_test' => "teams#rule_test_submit"
  # get '/team/:uid/rule_test_results' => "teams#rule_test_results"
  #
  # get '/team/:uid/about_poster' => "teams#about_poster"
  # post '/team/:uid/about_poster' => "teams#about_poster_submit"
  # get '/team/:uid/rule_test_results' => "teams#dashboard"

  get "/admin" => "admin/admin#dashboard", as: :admin
  namespace :admin do
    resources :teams do
      collection do
        get :race
        get :before
        get :survival
        get :results
      end
    end
  end

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
