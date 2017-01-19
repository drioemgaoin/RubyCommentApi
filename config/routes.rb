Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  
  resources :comments

  get '/api' => redirect('/swagger/dist/index.html?url=/apidocs/api-docs.json')
end
