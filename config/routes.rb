Rails.application.routes.draw do
  root to: "events#index"
  resources :events do
    resources :applications do
      get :confirm, to: "applications#confirm"
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
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
