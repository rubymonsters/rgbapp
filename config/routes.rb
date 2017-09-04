Rails.application.routes.draw do

  resources :events do
    resources :applications
  end

  put "/events/:event_id/applications", to: "applications#select"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
