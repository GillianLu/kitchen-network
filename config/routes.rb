Rails.application.routes.draw do
  devise_for :users

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

  root to: 'job_listings#index'
end
