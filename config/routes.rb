Kantoliina::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controllers and :action
  match "/" => redirect("/members"), :conditions => lambda { |req| !req.session["admin_id"].blank? }
  match "/" => redirect("/login")
  get 'login' => 'sessions#new', :as => 'login'
  post 'login' => 'sessions#create', :as =>'login'
  get 'logout' => 'sessions#destroy', :as => 'logout'

  get 'partnerlogin' => 'partner_sessions#new', :as => 'partner_login'
  post 'partnerlogin' => 'partner_sessions#create', :as =>'partner_login'
  get 'partnerlogout' => 'partner_sessions#destroy', :as => 'partner_logout'

  get "invoice/confirm" => 'invoice#index', :as => 'invoice_confirm'
  post "invoice/confirm" => 'invoice#index', :as => 'invoice_confirm'

  get "random/confirm" => 'random#random', :as => 'random_confirm'
  post "random/confirm" => 'random#random', :as => 'random_confirm'

  get "invoice" => 'invoice#create'
  post "invoice" => 'invoice#create'
  put 'invoice' => 'invoice#update'
  get "invoice/edit" => "invoice#edit"
  get 'invoice/loaddefault' => 'invoice#load_default'
  get 'invoice/preview' => 'invoice#preview'

  get "reminder/confirm" => 'reminder#index', :as => 'reminder_confirm'
  post "reminder/confirm" => 'reminder#index', :as => 'reminder_confirm'

  get "reminder" => 'reminder#create'
  post "reminder" => 'reminder#create'
  put 'reminder' => 'reminder#update'
  get "reminder/edit" => "reminder#edit"
  get 'reminder/loaddefault' => 'reminder#load_default'


  post "delete" => 'members#delete'
  post "payment" => 'members#payment'
  post "unpayment" => 'members#unpayment'
  post "random" => 'random#index', :as => 'random'


  post "mailer/confirm" => 'mailer#index', :as => 'mailer_confirm'
  get "mailer/confirm" => 'mailer#index'
  post "mailer" => 'mailer#create'
  put 'mailer' => 'mailer#update'
  post 'mailer/upload' => 'mailer#upload'

  get 'members/search' => "members#search"
  post 'members/addressdata' => "members#addressdata"

  put 'settings' => 'settings#update'

  resources :settings, :only => [:index]
  resources :accountcontrols, :only => [:index]
  resources :admins, :only => [:update]
  resources :partners, :only => [:index, :update]
  resources :password_resets, :only => [:new, :create]
  resources :members
  resources :membergroups
  resources :reminder
  resources :random



  #get 'userpage'=> 'members'
  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controllers actions automatically):
  #   resources :products
  # Sample resource route with options:
  #   resources :products do
  #     members do
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

  # root :to => 'admins#loginform'
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controllers route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controllers accessible via GET requests.
  # match ':controllers(/:action(/:id))(.:format)'
end
