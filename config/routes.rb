Rails.application.routes.draw do
  
  root 'welcome#index'
  devise_for :users, :controllers => {:registrations => "registrations"}


  get 'add_to_cart', to: 'shopping_cart#add_to_cart', format: :js
  get 'remove_from_cart', to: 'shopping_cart#remove_from_cart'
  get 'clean_cart', to: 'shopping_cart#clean_cart'

  get 'cart', to: 'shopping_cart#cart'
  get 'checkout', to: 'checkout#index'

end
