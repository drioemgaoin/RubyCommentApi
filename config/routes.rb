Rails.application.routes.draw do
  resources :comments

  get '/api' => redirect('/swagger/dist/index.html?url=/apidocs/api-docs.json')
end
