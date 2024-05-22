Rails.application.routes.draw do
  devise_for :users,
    controllers: {
      registrations: 'users/registrations'
    }

  # Defines the root path route ("/")
  root 'job_listings#index'

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
end
