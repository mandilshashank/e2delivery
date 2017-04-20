Rails.application.routes.draw do
  get 'welcome/index'
  get 'about/index'
  get 'contact/index'

  #define resources here
  resources :orders

  #Define paths here
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
