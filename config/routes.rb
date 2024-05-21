Rails.application.routes.draw do
  devise_for :users
  resources :job_listings

  root to: 'job_listings#index'
end
