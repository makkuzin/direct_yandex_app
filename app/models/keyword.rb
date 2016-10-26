class Keyword < ApplicationRecord
  belongs_to :campaign
  validates :id, presence: true

  def self.update_table(direct)
    data = get_remote_data(direct)
    data.each do |received_keyword|
      params = {
	id: received_keyword["Id"],
	campaign_id: received_keyword["CampaignId"],
	name: received_keyword["Keyword"],
	impressions: received_keyword["StatisticsSearch"]["Impressions"].to_i,
	clicks: received_keyword["StatisticsSearch"]["Clicks"].to_i,
	bid: received_keyword["Bid"].to_i
      }
      Keyword.create_or_update({id: params[:id], campaign_id: params[:campaign_id]}, params)
    end
  end

  def self.get_remote_data(direct, campaign_ids = Campaign.ids)
    direct.keywords.get({
      "SelectionCriteria" => { "CampaignIds" => campaign_ids },
      "FieldNames" => ["Id", "CampaignId", "Keyword", "Bid", "StatisticsSearch"]
    })["result"]["Keywords"]
  end

  def self.total_impressions
    pluck(:impressions).sum
  end

  def self.total_clicks
    pluck(:clicks).sum
  end

  def self.total_bid
    pluck(:bid).sum
  end
end
