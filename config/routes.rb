Rails.application.routes.draw do
  resources :projects do
    resources :tickets
  end
  root to: 'projects#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
