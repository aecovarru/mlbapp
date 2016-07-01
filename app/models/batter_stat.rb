class BatterStat < ApplicationRecord
  belongs_to :batter

  def h
    single + double + triple + homerun
  end

  def bb
    ibb + ubb
  end
end
