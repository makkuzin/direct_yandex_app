class Campaign < ApplicationRecord
  has_many :keywords, dependent: :delete_all
  validates :id, presence: true

  UPDATE_ROW_PERIOD = 10

  def self.update_table(direct)
    data = get_remote_data(direct)
    data.each do |received_campaign|
      c = Campaign.find_or_create_by(id: received_campaign["Id"]) do |campaign|
	campaign.id = received_campaign["Id"]
	campaign.name = received_campaign["Name"]
      end
      if (Time.now - c.updated_at) > UPDATE_ROW_PERIOD
	update_params = { 
	  id: received_campaign["Id"],
	  name: received_campaign["Name"]
	}
	c.update(update_params) 
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
