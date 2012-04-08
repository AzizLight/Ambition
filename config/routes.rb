Ambition::Application.routes.draw do
  # Password Resets
  resources :password_resets, :only => [:new, :create, :edit, :update]

  # Sessions
  resources :sessions, :only => [:new, :create, :destroy]
  get '/login' => 'sessions#new'
  delete '/logout' => 'sessions#destroy'

  namespace :admin do
    # Activity logs
    get "activity_logs" => "activity_logs#index", :as => "activity_logs"
    delete "activity_logs/clear" => "activity_logs#clear", :as => "clear_activity_logs"

    # Reset sample data
    get "sample_data/reset" => "sample_data#reset", :as => "reset_sample_data"

    # Dashboard
    resources :dashboard, :only => [:index]

    # Users
    resources :users do
      get 'page/:page', :action => :index, :on => :collection
      get 'suspend', :action => :suspend, :as => 'suspend'
      get 'activate', :action => :activate, :as => 'activate'
      get 'adminize', :action => :adminize, :as => 'adminize'
      get 'deadminize', :action => :deadminize, :as => 'deadminize'
    end

    # Pages
    resources :pages, :except => [:show] do
      get 'page/:page', :action => :index, :on => :collection
    end
    get '/pages/:id/delete' => 'pages#delete', :as => 'delete_page'

    # Posts
    resources :posts, :except => [:show] do
      get 'page/:page', :action => :index, :on => :collection
    end
    get '/posts/:id/delete' => 'posts#delete', :as => 'delete_post'

    # Admin Root Path/URL
    root :to => 'dashboard#index'
  end

  # Posts
  get "/posts" => "posts#index"
  get "/:slug" => "posts#show"

  # Pages!
  get '/:slug/' => 'pages#show'

  root :to => 'sessions#new'
end
