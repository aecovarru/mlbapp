class GameDate < ApplicationRecord
  belongs_to :season
  has_many :games, dependent: :destroy
end
