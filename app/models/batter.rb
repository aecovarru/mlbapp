class Batter < ApplicationRecord
  belongs_to :owner, polymorphic: true
  belongs_to :player
  belongs_to :team
  has_many :batter_stats, dependent: :destroy
  validates_presence_of :player, :team, :owner

  scope :starters, -> { where(starter: true).order("lineup ASC")}
  
  def name
    player.name
  end

  def bathand
    player.bathand
  end

  def stat
    batter_stats.find_by(handed: "")
  end

  def lefty_stat
    batter_stats.find_by(handed: "L")
  end

  def righty_stat
    batter_stats.find_by(handed: "R")
  end
  
end
