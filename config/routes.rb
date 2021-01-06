Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }
  root "welcome#index"
  resource :retirements

  resources :events do
    resources :tickets
  end

end
