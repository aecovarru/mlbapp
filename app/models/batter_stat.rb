class BatterStat < ApplicationRecord
  belongs_to :batter

  def h
    single + double + triple + homerun
  end

  def bb
    ibb + ubb
  end

  def as_json(options={})
    super(options).merge({h: h, bb: bb})
  end
  
end
