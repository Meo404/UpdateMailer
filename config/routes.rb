Rails.application.routes.draw do

  devise_for :users
  root to: 'distribution_lists#index'

  get 'email_templates/templates' => 'email_templates#templates'
  resources :distribution_lists
  resources :update_mails
  resources :email_templates
end
