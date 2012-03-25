Ambition::Application.routes.draw do

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
    resources :pages, :except => [:show]
    match '/pages/:id/delete' => 'pages#delete'

    # Posts
    resources :posts, :except => [:show]
    match '/posts/:id/delete' => 'posts#delete'

    # Admin Root Path/URL
    root :to => "dashboard#index"
  end

  # Pages!
  get '/:slug/' => 'pages#show'

  root :to => 'sessions#new'
end
