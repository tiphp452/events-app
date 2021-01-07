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

  if Rails.env.development?
    require "sidekiq/web"
    mount Sidekiq::Web => "/sidekiq"
  end

end
