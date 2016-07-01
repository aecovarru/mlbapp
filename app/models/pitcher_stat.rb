class PitcherStat < ApplicationRecord
  belongs_to :pitcher

  def ip
    outs/3 + outs%3/10.0
  end

  def h
    single + double + triple + homerun
  end

  def bb
    ibb + ubb
  end
end
