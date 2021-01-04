Rails.application.routes.draw do
  resources :events
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }
  root "welcome#index"
end
