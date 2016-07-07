class Inning < ApplicationRecord
  belongs_to :game
  has_many :pitchers, as: :owner, dependent: :destroy
  has_many :batters,  as: :owner, dependent: :destroy
end
