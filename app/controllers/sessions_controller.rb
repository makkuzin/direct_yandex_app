class SessionsController < ApplicationController
  def create
    session[:api_token] = request.env['omniauth.auth']['credentials']['token'].to_s
    redirect_to report_path
  end
end
