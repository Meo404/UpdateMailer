Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout'}
  devise_scope :user do
    authenticated :user do
      root :to => 'statistics#index'
    end
    unauthenticated :user do
      root :to => 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  # Dashboard path
  get 'dashboard' => 'statistics#index'

  # Statistics data path
  get 'statistics/chartData' => 'statistics#chart_data'

  # Additional user routes
  get 'edit_profile' => 'users#edit_profile'
  patch 'users/update_profile'

  # Additional update mail routes
  get 'update_mails/view/:id' => 'update_mails#view'
  get 'update_mails/send_email/:id' => 'update_mails#send_email'

  # Additional email template routes
  get 'email_templates/templates' => 'email_templates#templates'

  resources :distribution_lists
  resources :update_mails
  resources :email_templates
  resources :users
end
