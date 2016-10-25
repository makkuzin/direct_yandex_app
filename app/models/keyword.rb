class Keyword < ApplicationRecord
  belongs_to :campaign

  def self.update_table(direct)
    data = get_remote_data(direct)
  end

  def self.get_remote_data(direct, campaign_ids = Campaign.ids)
    direct.keywords.get({
      "SelectionCriteria" => { "CampaignIds" => campaign_ids },
      "FieldNames" => ["CampaignId", "Keyword", "Bid", "StatisticsSearch"]
    })["result"]["Keywords"]
  end
end
