Intlman::Application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  root to: 'stories#show_stories'
  
  match '/stories',   to: 'stories#show_stories', :via => "get"
  match '/stories(/:category(/:article_title))', to: 'stories#show_stories_by_category',
    :constraints => { :category => /[a-z-]+/, :article_title => /[a-z\d-]+/ }, :via => "get"
   # match '/stories(/:category)(/:year)', to: 'stories#index',
   #   :constraints => { :category => /[a-z]+/, :year => /\d{4}/ }

  match '/tv(/:video_title)',      to: 'videos#show',
    :constraints => { :video_title => /[a-z\d-]+/ }, :as => "tv", :via => "get"
  match '/radio(/:track_title)',   to: 'radio_tracks#show',
    :constraints => { :track_title => /[a-z\d-]+/ }, :as => "radio", :via => "get"
  match '/corporate(/:article_title)',   to: 'corporate_articles#show',
    :constraints => { :article_title => /[a-z\d-]+/ }, :as => "corporate", :via => "get"

  match '/blog(/:post_title)',    to: 'posts#show',
    :constraints => { :post_title => /[a-z\d-]+/ }, :as => "blog", :via => "get"
  # match '/blog(/:category)(/:year)(/:month)',    to: 'posts#index', :via => "get"

  match '/map',     to: 'pages#map', :via => "get"
  match '/about',   to: 'pages#about', :via => "get"
  match '/contact', to: 'pages#contact', :via => "get"

  match '/feed' => 'stories#feed', :as => :feed, :defaults => { :format => 'atom' }
  
  match '/search', to: 'stories#search', :via => 'get', :as => :search

  devise_scope :admin_user do
    match '/refresh_facebook_data_remote', to: 'stories#refresh_facebook_data_remote', :as => :refresh_facebook_data_remote
    match '/get_facebook_items_to_refresh', to: 'stories#get_facebook_items_to_refresh', :as => :get_facebook_items_to_refresh
    match '/rebuild_pg_search_index', to: 'stories#rebuild_pg_search_index', :as => :rebuild_pg_search_index
  end

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'

  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActionDispatch::Routing::Translator.translate_from_file('config/locales/routes.yml', { :prefix_on_default_locale => true, :keep_untranslated_routes => true })
end
