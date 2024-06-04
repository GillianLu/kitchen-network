Rails.application.routes.draw do
  get 'profiles/show'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }

  devise_scope :user do
    get '/admin/sign_up', to: 'users/registrations#new_admin', as: 'new_admin_registration'
    post '/admin/sign_up', to: 'users/registrations#create_admin', as: 'create_admin_registration'
  end

  root 'home#index'

  get 'account/confirmed', to: 'home#confirmed', as: 'confirmed'
  get 'account/registered', to: 'home#registered', as: 'registered'

  get '/dashboard', to: 'home#dashboard', as: 'dashboard'
  get '/reviews', to: 'home#reviews', as: 'reviews'
  get '/transactions', to: 'home#transactions', as: 'transactions'
  get '/search/job', to: 'home#search_job', as: 'search_job'

  resources :job_listings do
    resources :reviews
    collection do
      get 'browse'
      get 'all_applicants'

    end
    member do
      get 'applicants'
      get 'confirm_applicant/:applicant_id', action: :confirm_applicant, as: 'confirm_applicant'
      get 'reject_applicant/:applicant_id', action: :reject_applicant, as: 'reject_applicant'
    end
  end

  resources :applied_jobs, only: [:index, :destroy] do
    collection do
      post 'apply'
    end
  end

  namespace :admin do
    resources :users, only: [:index, :edit, :update]
    get 'talents', to: 'users#talents'
    get 'users/pending', to: 'users#pending_users'
  end


  resources :payments, only: [:new, :create] do
    collection do
      get 'new_complete'
    end
  end

  resources :transactions, only: [:index]

  resources :profiles, only: [:show] do
    collection do
      get 'talents'
    end
  end

  resources :message
  get '/inbox', to: 'message#inbox', as: 'inbox'
  get '/conversation', to: 'message#conversation', as: 'conversation'

end
