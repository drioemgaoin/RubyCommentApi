Rails.application.routes.draw do
  resources :comments

  root "api#index"
end
