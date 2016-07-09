namespace :setup do

  task test: :environment do

    Game.all.each do |game|
      weather = game.weathers.order("hour").first
      if weather && (game.weathers.size != 3 || weather.hour != game.hour)
        game.weathers.destroy_all
      end
    end

  end

  task hi: :environment do
    include Download
    url = "https://www.wunderground.com/history/airport/KMDW/2016/7/5/DailyHistory.html?req_city=Chicago&req_state=IL&req_statename=Illinois&reqdb.zip=60290&reqdb.magic=1&reqdb.wmo=99999"
    doc = download_document(url)
    unless doc
      puts "FAIL"
    end
  end

end