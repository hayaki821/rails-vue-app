Rails.application.routes.draw do

  namespace :api, format: 'json' do
    resources :tasks, only: [:index, :create, :update]
  end

  root to: 'home#index'  
  get '/*path', to: 'home#index' 
end
