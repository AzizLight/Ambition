Ambition::Application.routes.draw do
  root :to => 'sessions#new'

  get '/:slug/' => 'pages#show'

  # Password Resets
  resources :password_resets, :only => [:new, :create, :edit, :update]

  # Sessions
  resources :sessions, :only => [:new, :create, :destroy]
  match '/login' => 'sessions#new'
  match '/logout' => 'sessions#destroy'

  namespace :admin do
    # Dashboard
    resources :dashboard, :only => [:index]

    # Users
    resources :users, :only => [:new, :create]

    # Pages
    resources :pages
    match '/pages/:id/delete' => 'pages#delete'

    # Posts
    resources :posts
    match '/posts/:id/delete' => 'posts#delete'

    # Admin Root Path/URL
    root :to => "dashboard#index"
  end
end
