Rails.application.routes.draw do
  devise_for :users,
    controllers: {
      registrations: 'users/registrations',
      confirmations: 'users/confirmations'
  }

  # Defines the root path route ("/")
  # root 'job_listings#index'

  root 'home#index'

  get 'account/confirmed', to: 'home#confirmed', as: 'confirmed'
  get 'account/registered', to: 'home#registered', as: 'registered'

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
end
