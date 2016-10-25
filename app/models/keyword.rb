class Keyword < ApplicationRecord
  belongs_to :campaign

  def self.update_table(direct)
    data = get_remote_data(direct)
    data.each do |received_keyword|
      params = { campaign_id: received_keyword["CampaignId"],
		 name: received_keyword["Keyword"],
		 impressions: received_keyword["StatisticsSearch"]["Impressions"].to_i,
		 clicks: received_keyword["StatisticsSearch"]["Clicks"].to_i,
		 bid: received_keyword["CampaignId"].to_i }
      keyword = Keyword.find_or_create_by(name: params["Keyword"],
					  campaign_id: params["CampaignId"]) do |k|
	k.campaign_id = params[:campaign_id]
	k.name = params[:name]
	k.impressions = params[:impressions]
	k.clicks = params[:clicks]
	k.bid = params[:bid]
      end
      if (Time.now - keyword.updated_at) > UPDATE_ROW_PERIOD
	keyword.update(params)
      end
    end
  end

  def self.get_remote_data(direct, campaign_ids = Campaign.ids)
    direct.keywords.get({
      "SelectionCriteria" => { "CampaignIds" => campaign_ids },
      "FieldNames" => ["CampaignId", "Keyword", "Bid", "StatisticsSearch"]
    })["result"]["Keywords"]
  end
end
