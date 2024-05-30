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

  resources :job_listings do
    resources :reviews
    collection do
      get 'browse'
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
    resources :users, only: [:index, :edit, :update, :show] do
      collection do
        get 'talents'
        get 'pending', to: 'users#pending_users'
      end
    end
  end


  resources :payments, only: [:new, :create] do
    collection do
      get 'new_complete'
    end
  end

  resources :transactions, only: [:index]
<<<<<<< HEAD
=======
  
  resources :profiles, only: [:show]

>>>>>>> 1e52c2afe529b7122c184b44965c73fcbd3d8896

end
