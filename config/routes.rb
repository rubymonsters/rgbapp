Rails.application.routes.draw do

  mount ActionCable.server => '/cable'
  
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/sign_in" => "sessions#new_admin", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  delete "/coaches/sign_out" => "sessions#destroy_coach", as: "coaches_sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  get "/coaches/sign_in" => "sessions#new_coach", as: "coaches_sign_in"
  get "/logged_in" => "sessions#logged_in", as: "logged_in"
  post "/session" => "sessions#create", as: "session"

  root to: "events#index"
  resources :coaches do
    collection do
      get 'sign_up', to: 'coaches#new'
      get 'events', to: 'events#index_for_coaches'
    end
  end
  resources :events do
    resources :applications do
      get :confirm, to: "applications#confirm"
    end
    resources :coach_applications
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
