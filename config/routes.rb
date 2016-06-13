Rails.application.routes.draw do
  get 'test/index'

  devise_for :users
end
