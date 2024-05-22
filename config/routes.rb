Rails.application.routes.draw do
  devise_for :users

  resources :job_listings do
    collection do
      get 'browse'
    end
  end

  resources :applied_jobs, only: [:index] do
    collection do
      post 'apply'
    end
  end

  root to: 'job_listings#index'
end
