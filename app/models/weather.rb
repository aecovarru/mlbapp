class Weather < ApplicationRecord
  belongs_to :game

  def as_json(option={})
    time = convert_time(game.time, self, game.home_team)
    super(option).merge({time: time})
  end


  private

    def convert_time(time, weather, home_team)
      index = time.index(":")
      hour = time[0...index].to_i + home_team.timezone + weather.hour - 1
      hour -= 12 if hour > 12
      return hour.to_s + time[index..-1]
    end

end
