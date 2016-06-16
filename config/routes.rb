Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout'}
  devise_scope :user do
    authenticated :user do
      root :to => 'update_mails#index'
    end
    unauthenticated :user do
      root :to => 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  # root to: 'distribution_lists#index'

  get 'update_mails/view/:id' => 'update_mails#view'
  get 'update_mails/send_email/:id' => 'update_mails#send_email'
  get 'email_templates/templates' => 'email_templates#templates'
  resources :distribution_lists
  resources :update_mails
  resources :email_templates
end
