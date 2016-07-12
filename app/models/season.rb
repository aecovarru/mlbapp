class Season < ApplicationRecord
  validates_presence_of :year
  has_and_belongs_to_many :teams
  has_many :game_dates, dependent: :destroy
  has_many :games,     dependent: :destroy
  has_many :pitchers, as: :owner, dependent: :destroy
  has_many :batters, as: :owner, dependent: :destroy

  def as_json(options={})
    { id: id, year: year, games_link: "seasons/#{id}/games" }
  end
  
end
