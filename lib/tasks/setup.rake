namespace :setup do

  task test: :environment do

    Game.all.each do |game|
      weather = game.weathers.first
      if weather && weather.hour == game.hour
        game.weathers.destroy_all
      end
    end

  end

end