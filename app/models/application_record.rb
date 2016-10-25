class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.create_or_update(properties, params)
    model = self.find_by(properties)
    if model.nil?
      self.create(params)
    else
      model.update(params)
    end
  end
end
