class Weather < ApplicationRecord
  belongs_to :game

  def as_json(option={})
    super(option).merge({time: "#{hour-12}:00 PM"})
  end

end
