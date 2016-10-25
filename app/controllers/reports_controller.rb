class ReportsController < ApplicationController
  def show
    # loads data from db
    if session.key?(:api_token)
      token = session[:api_token]
      direct = Ya::API::Direct::Client.new({
	token: token,
	mode: :sandbox
      })
      @campaigns = direct.campaigns.get({
	"SelectionCriteria" => {},
	"FieldNames" => ["Id", "Name"]})["result"]["Campaigns"]
      @keywords = direct.keywords.get({
	"SelectionCriteria" => {"CampaignIds" => [160866,160867,160868]},
	"FieldNames" => ["CampaignId", "Keyword", "Bid", "StatisticsSearch"]})["result"]["Keywords"]
    else
      @campaigns = @keywords = []
    end
  end

  def update
    # updates db and redirects to show
    session[:api_token] = request.env['omniauth.auth']['credentials']['token'].to_s
    redirect_to root_path
  end
end
