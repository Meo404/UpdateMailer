Rails.application.routes.draw do
  devise_for :users

  resources :distribution_lists
end
