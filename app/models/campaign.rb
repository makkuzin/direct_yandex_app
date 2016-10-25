class Campaign < ApplicationRecord
  has_many :keywords, dependent: :delete_all
  validates :id, presence: true

  def self.update_table(direct)
    data = get_remote_data(direct)
    data.each do |received_campaign|
      params = { id: received_campaign["Id"],
		 name: received_campaign["Name"] }
      campaign = Campaign.find_or_create_by(id: params[:id]) do |c|
	c.id = params[:id]
	c.name = params[:name]
      end
      if (Time.now - campaign.updated_at) > UPDATE_ROW_PERIOD
	campaign.update(params) 
      end
    end
  end

  def self.get_remote_data(direct)
    direct.campaigns.get({
      "SelectionCriteria" => {},
      "FieldNames" => ["Id", "Name"]
    })["result"]["Campaigns"]
  end
end
