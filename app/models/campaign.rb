class Campaign < ApplicationRecord
  has_many :keywords, dependent: :delete_all
end
