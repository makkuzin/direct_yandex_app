Rails.application.routes.draw do
  resource :report, only: [:show, :update, :destroy]
  get '/auth/:provider/callback' => 'reports#update'
  root 'reports#show'
end
