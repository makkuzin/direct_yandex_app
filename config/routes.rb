Rails.application.routes.draw do
  resource :report, only: [:show, :update]
  get '/auth/:provider/callback' => 'reports#update'
  root 'reports#show'
end
