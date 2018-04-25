Rails.application.routes.draw do
  root to: "businesses#index"

  resources :sessions, only: [:create]
  get "/login", to: "sessions#new"
  get "/logout", to: "sessions#destroy"

  resources :categories, only: [:show] do
    resources :sub_categories, only: [:show], path: "tags"
  end

  resources :conversations, only: [:index, :show, :new, :create] do
    resources :messages, only: [:create]
    collection do
      post :trash
    end
  end

  resources :events, only: [:index]
  resources :topics, only: [:index], path: "talk"
  resources :businesses, only: [:index]
  get "search", to: "searches#show"

  resources :cities, only: [], path: "c" do
    resources :categories, only: [:show], path: "cat" do
      resources :sub_categories, only: [:show], path: "tags"
    end

    get "u", to: "users#city_index"
    get "events", to: "events#city_index"
    get "businesses", to: "businesses#city_index"
    get "topics", to: "topics#city_index", path: "talk"

    resources :topics, only: [:show, :new, :create], path: "talk" do
      resources :posts, only: [:create]
    end

    post "create_business", to: "businesses#create"
    resources :businesses, only: [:show, :new, :edit, :update, :destroy], path: "b" do
      resources :reviews, only: [:new, :create, :edit, :update, :destroy]
      resources :events, only: [:show, :new, :create, :edit, :update, :destroy], path: "e"
      resources :business_pics, only: [:create, :show, :index], as: "photos", path: "photos"
      member do
        get :details
        post :write_details
      end
    end
  end

  resources :users, only: [:index, :show, :create, :edit, :update], path: "u" do
    member do
      get "photos", to: "business_pics#user_index", path: "photos"
    end
  end

  get "/signup", to: "users#new"

  post 'friend_user/:id', to: 'friendships#status', as: 'friend_user'
  post 'follow_user/:id', to: 'followings#status', as: 'follow_user'
  post 'attend_event/:id', to: 'attend_events#status', as: 'attend_event'
  post 'review_stats/:id', to: 'review_stats#status', as: 'review_stats'
  post 'bookmark/:id', to: 'bookmarks#status', as: 'bookmark'

  get 'forgot_password', to: 'forgot_passwords#new'
  resources :forgot_passwords, only: [:create]
  get 'forgot_password_confirmation', to: 'forgot_passwords#confirm'

  resources :password_resets, only: [:show, :create]
  get 'expired_token', to: 'password_resets#expired_token'

  get '/test_cards', to: 'donations#test_cards'
  get '/donate', to: 'donations#new'
  resources :donations, only: [:create]

  namespace :admin do
    resources :users, only: [:destroy]
    resources :posts, only: [:destroy]
    resources :topics, only: [:destroy]
    resources :payments, only: [:index]
  end

  get '*path' => redirect('/')
end
