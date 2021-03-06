class Campaign < ApplicationRecord
  has_many :keywords, dependent: :delete_all
  validates :id, presence: true

  def self.update_table(direct)
    data = get_remote_data(direct)
    data.each do |received_campaign|
      params = { 
	id: received_campaign["Id"],
	name: received_campaign["Name"]
      }
      Campaign.create_or_update({id: params[:id]}, params)
    end
  end

  def self.get_remote_data(direct)
    direct.campaigns.get({
      "SelectionCriteria" => {},
      "FieldNames" => ["Id", "Name"]
    })["result"]["Campaigns"]
  end

  def impressions_sum
    keywords.pluck(:impressions).sum
  end

  def clicks_sum
    keywords.pluck(:clicks).sum
  end

  def bid_sum
    keywords.pluck(:bid).sum
  end
end
