Ambition::Application.routes.draw do

  # Password Resets
  resources :password_resets, :only => [:new, :create, :edit, :update]

  # Sessions
  resources :sessions, :only => [:new, :create, :destroy]
  get '/login' => 'sessions#new'
  delete '/logout' => 'sessions#destroy'

  namespace :admin do
    # Dashboard
    resources :dashboard, :only => [:index]

    # Users
    resources :users

    # Pages
    resources :pages, :except => [:show] do
      get 'page/:page', :action => :index, :on => :collection
    end
    get '/pages/:id/delete' => 'pages#delete', :as => "delete_page"

    # Posts
    resources :posts, :except => [:show] do
      get 'page/:page', :action => :index, :on => :collection
    end
    get '/posts/:id/delete' => 'posts#delete', :as => "delete_post"

    # Admin Root Path/URL
    root :to => "dashboard#index"
  end

  # Pages!
  get '/:slug/' => 'pages#show'

  root :to => 'sessions#new'
end
