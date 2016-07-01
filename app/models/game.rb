class Game < ApplicationRecord
  belongs_to :season
  belongs_to :game_date
  belongs_to :away_team, class_name: "Team"
  belongs_to :home_team, class_name: "Team"
  has_many :pitchers, as: :owner, dependent: :destroy
  has_many :batters, as: :owner, dependent: :destroy
  has_many   :innings,  dependent: :destroy

  def url
    date = game_date.date
    "%s%d%02d%02d%d" % [home_team.alt_abbr, date.year, date.month, date.day, num]
  end

  def away_batters
    batters.where(team: away_team)
  end

  def home_batters
    batters.where(team: home_team)
  end

  def away_pitchers
    pitchers.where(team: away_team)
  end

  def home_pitchers
    pitchers.where(team: home_team)
  end

  def as_json(options={})
    { id: id, date: game_date.date.to_s, away_team: away_team.name, home_team: home_team.name, show_link: "games/#{id}" }
  end

end
