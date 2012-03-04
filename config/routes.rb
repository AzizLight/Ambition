Ambition::Application.routes.draw do
  root :to => "sessions#new"

  # Password Resets
  resources :password_resets, :only => [:new, :create, :edit, :update]

  # Sessions
  resources :sessions, :only => [:new, :create, :destroy]
  match '/login' => 'sessions#new'
  match '/logout' => 'sessions#destroy'

  namespace :admin do
    root :to => "users#new"
    resources :users, :only => [:new, :create]
  end
end
