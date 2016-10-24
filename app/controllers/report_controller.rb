class ReportController < ApplicationController
  def index
    redirect_to root_path unless session.key?(:api_token)
  end
end
