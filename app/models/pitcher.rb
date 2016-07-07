class Pitcher < ApplicationRecord
  belongs_to :owner, polymorphic: true
  belongs_to :player
  belongs_to :team
  has_many   :pitcher_stats, dependent: :destroy
  validates_presence_of :player, :team, :owner

  scope :starters, -> { where(starter: true) }

  def name
    player.name
  end

  def throwhand
    player.throwhand
  end

  def stat
    pitcher_stats.find_by(handed: "")
  end

  def lefty_stat
    pitcher_stats.find_by(handed: "L")
  end

  def righty_stat
    pitcher_stats.find_by(handed: "R")
  end

  def as_json(options={})
    { id: id, name: player.name, starter: starter, stat: stat.as_json }
  end
  
end
