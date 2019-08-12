Rails.application.routes.draw do

  mount ActionCable.server => '/cable'

  root to: "events#index"
  resources :events do
    resources :applications do
      get :confirm, to: "applications#confirm"
      get :cancel, to: "applications#cancel"
    end
  end

  namespace :admin do
    root to: "events#index"
    resources :users
    resources :events do
      resources :applications
      put :applications, to: "applications#checkboxes"
      put :complete
      put :send_emails
      resources :templates
      resources :attendants
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
