Rails.application.routes.draw do

  devise_for :users
  root to: 'distribution_lists#index'

  get 'email_templates/get_templates' => 'email_templates#get_templates'
  resources :distribution_lists
  resources :update_mails
  resources :email_templates
end
