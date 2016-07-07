namespace :setup do

  task test: :environment do

    Game.all.each do |game|
      weather = game.weathers.order("hour").first
      if weather && (game.weathers.size != 3 || weather.hour != game.hour)
        game.weathers.destroy_all
      end
    end

  end

end