Rails.application.routes.draw do
  
  resources :roles
  resources :items
  resources :categories

  devise_for :users,
    controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
    }
  get '/account' => 'accounts#show'
  get '/current_user', to: 'current_user#index'
end
