class Game < ApplicationRecord
  belongs_to :season
  belongs_to :game_date
  belongs_to :away_team, class_name: "Team"
  belongs_to :home_team, class_name: "Team"
  has_many :pitchers, as: :owner, dependent: :destroy
  has_many :batters, as: :owner, dependent: :destroy
  has_many :weathers, dependent: :destroy
  has_many :innings, dependent: :destroy

  def url
    date = game_date.date
    "%s%d%02d%02d%d" % [home_team.alt_abbr, date.year, date.month, date.day, num]
  end

  def away_batters
    batters.where(team: away_team).order("lineup")
  end

  def home_batters
    batters.where(team: home_team).order("lineup")
  end

  def away_pitchers
    pitchers.where(team: away_team).order("id")
  end

  def home_pitchers
    pitchers.where(team: home_team).order("id")
  end

  def weather
    weathers.find_by(hour: hour)
  end

  def as_json(options={})
    date = game_date.date
    { id: id, date: date.strftime("%Y/%m/%d"), year: date.year, month: date.month, day: date.day, away_team: away_team.name, home_team: home_team.name,
      away_score: away_score, home_score: home_score, show_link: "games/#{id}", weather: weather.as_json }
  end

end
