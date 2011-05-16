# -*- encoding : utf-8 -*-
Stuinfo::Application.routes.draw do

  resources :talk_records

  resources :watch_list_items

  resources :programs

  resources :messages


  resources :tables

  resources :courses

  resources :import3_logs

  resources :import4_logs

  resources :import2_logs

  resources :comments

  resources :users
  devise_for :users,:path => 'accounts'


  resources :import_logs

  resources :students
  get '/students/:id/school_report' => 'students#school_report'
  get '/students/:id/talk_records' => 'students#talk_records'

  resources :klasses

  resources :grades

  get 'main' => 'welcome#main'
  get 'import' => 'welcome#import'
  get 'import2' => 'welcome#import2'
  get 'import3' => 'welcome#import3'
  get 'import4' => 'welcome#import4'
  get '/welcome/menu' => 'welcome#menu'
  get '/welcome/top' => 'welcome#top'
  get '/auto_import' => 'welcome#auto_import'
  post '/core/import' => 'core#import'
  post '/core/import2' => 'core#import2'
  get '/inquiry/table' => 'inquiry#table'
  post '/inquiry/tableStep1' => 'inquiry#tableStep1'
  post '/inquiry/tableStep2' => 'inquiry#tableStep2'
  post '/inquiry/tableStep3' => 'inquiry#tableStep3'
  post '/inquiry/tableFinish' => 'inquiry#tableFinish'
  post '/inquiry/tableConfirmed' => 'inquiry#tableConfirmed'
  get '/grades/:grade_id/students' => 'students#index'
  get '/klasses/:klass_id/students' => 'students#index'
  get '/klass2s/:klass2_id/students' => 'students#index'
  get '/courses/:course_id/students' => 'students#index'
  get "/messages/:message_id/set_read" => 'messages#set_read'
  get "/messages/:message_id/set_unread" => 'messages#set_unread'
  get '/warnings/credit' => 'warnings#index_credit'
  get '/warnings/score' => 'warnings#index_score'
  get '/warnings/event' => 'warnings#index_event'
  get '/warnings/psychological' => 'warnings#index_psychological'
  resources :warnings
  get '/inquiry/watchlist' => 'inquiry#watchlist'
  get '/inquiry/talk' => 'inquiry#talk'
  get '/inquiry/graduate' => 'inquiry#graduate'
  get '/researches/chuangye' => 'researches#chuangye'
  get '/researches/keyan' => 'researches#keyan'
  get '/researches/jijin' => 'researches#jijin'
  resources :researches
  get '/settings' => 'welcome#settings', as:'settings'
  get '/system_jobs/update_credit' => 'core#system_jobs_update_credit'
  get '/system_jobs/update_klass2s' => 'core#system_jobs_update_klass2s'
  get '/system_jobs' => 'core#system_jobs_index'
  post '/students/:student_id/update_scores' => 'students#update_scores'
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
end
