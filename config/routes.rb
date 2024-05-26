Rails.application.routes.draw do
  devise_for :users,
    controllers: {
       registrations: 'users/registrations',
       confirmations: 'users/confirmations'
    }

   devise_scope :user do
    get '/admin/sign_up', to: 'users/registrations#new_admin', as: 'new_admin_registration'
    post '/admin/sign_up', to: 'users/registrations#create_admin', as: 'create_admin_registration'
  end

  # Defines the root path route ("/")
  # root 'job_listings#index'

  root 'home#index'

  get 'account/confirmed', to: 'home#confirmed', as: 'confirmed'
  get 'account/registered', to: 'home#registered', as: 'registered'


  get '/dashboard', to: 'home#dashboard', as: 'dashboard'

  resources :job_listings do
    collection do
      get 'browse'
    end
    member do
      get 'applicants'
    end
  end

  resources :applied_jobs, only: [:index] do
    collection do
      post 'apply'
    end
    member do
      patch 'confirm'
      patch 'reject'
    end
  end

  namespace :admin do
    resources :users, only: [:index, :edit, :update]
    get 'talents', to: 'users#talents'
    get 'users/pending', to: 'users#pending_users'
  end

  resources :payments, only: [:new, :create]
end
