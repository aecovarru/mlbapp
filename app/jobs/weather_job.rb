class WeatherJob < ApplicationJob
  queue_as :default

  include Download

  def perform(*args)
    # Do something later
    if args[0].respond_to?(:each)
      args[0].each do |game|
        create_weathers(game)
      end
    else
      create_weathers(args[0])
    end
  end

  private

    def create_weathers(game)
      date = game.game_date.date
      team = game.home_team
      @hour = game.hour == 0 ? 18 : game.hour
      end_hour = @hour + 3
      url = find_url(team, date)
      puts game.id
      doc = nil
      until doc
        doc = download_document(url)
      end
      puts url
      size = doc.css("#obsTable th").size
      return if size == 0
      index_hash = {temp: 1, dew: 2, humidity: 3, pressure: 4, wind_dir: 6, wind_speed: 7, precip: 9}
      update_index_hash(index_hash, size)
      doc.css("#obsTable td").each_slice(size) do |slice|
        time = slice[0].text
        if match_time(time)
          temp = slice[index_hash[:temp]].text.strip[0..3].to_f
          dew = slice[index_hash[:dew]].text.strip[0..3].to_f
          humidity = slice[index_hash[:humidity]].text.strip[0..1].to_i
          pressure = slice[index_hash[:pressure]].text.strip[0...-3].to_f
          wind_dir = slice[index_hash[:wind_dir]].text.strip
          wind_speed = get_wind_speed(slice[index_hash[:wind_speed]].text.strip)
          precip = get_precip(slice[index_hash[:precip]].text.strip)
          air_density = Build::AirDensity.new.run(convert_in_to_mb(pressure), temp, dew)
          weather = Weather.find_or_create_by(game: game, hour: @hour)
          weather.update(temp: temp, dew: dew, humidity: humidity, pressure: pressure, wind_dir: wind_dir, wind_speed: wind_speed, precip: precip, air_density: air_density)
          @hour += 1
          break if @hour == end_hour
        end
      end
    end

    def get_precip(text)
      text == "N/A" ? 0.0 : text[0..3].to_f
    end

    def convert_in_to_mb(inches)
      (inches * 33.86375257787817).round(2)
    end

    def get_wind_speed(text)
      index = text.index(".")
      index ? text[0...index+2].to_f : 0.0
    end

    def update_index_hash(index_hash, size)
      if size == 13
        index_hash.each do |k, v|
          index_hash[k] += 1 unless k == :temp
        end
      end
    end

    def find_url(team, date)
      url = @@urls[team.id - 1]
      find = "year/month/day"
      replace = "#{date.year}/#{date.month}/#{date.day}"
      url.gsub(/#{find}/, replace)
    end

    def match_time(time)
      period = time[-2..-1]
      time = time[0...time.index(":")].to_i
      if period == "PM" && time != 12
        time += 12
      end
      if @hour == time
        return true
      end
    end

    @@urls = ["https://www.wunderground.com/history/airport/KFUL/year/month/day/DailyHistory.html?req_city=Anaheim&req_state=CA&req_statename=California&reqdb.zip=92801&reqdb.magic=1&reqdb.wmo=99999", "https://www.wunderground.com/history/airport/KHOU/year/month/day/DailyHistory.html?req_city=Houston&req_statename=Texas", "https://www.wunderground.com/history/airport/KOAK/year/month/day/DailyHistory.html?req_city=Oakland&req_statename=California",
      "https://www.wunderground.com/history/airport/CYTZ/year/month/day/DailyHistory.html?req_city=Toronto&req_statename=Ontario", "https://www.wunderground.com/history/airport/KPDK/year/month/day/DailyHistory.html?req_city=Atlanta&req_statename=Georgia", "https://www.wunderground.com/history/airport/KMKE/year/month/day/DailyHistory.html?req_city=Milwaukee&req_statename=Wisconsin",
      "https://www.wunderground.com/history/airport/KSTL/year/month/day/DailyHistory.html?req_city=Saint%20Louis&req_statename=Missouri", "https://www.wunderground.com/history/airport/KMDW/year/month/day/DailyHistory.html?req_city=Chicago&req_state=IL&req_statename=Illinois&reqdb.zip=60290&reqdb.magic=1&reqdb.wmo=99999", "https://www.wunderground.com/history/airport/KPHX/year/month/day/DailyHistory.html?req_city=Phoenix&req_statename=Arizona",
      "https://www.wunderground.com/history/airport/KCQT/year/month/day/DailyHistory.html?req_city=Los%20Angeles&req_statename=California", "https://www.wunderground.com/history/airport/KSFO/year/month/day/DailyHistory.html?req_city=San%20Francisco&req_statename=California", "https://www.wunderground.com/history/airport/KBKL/year/month/day/DailyHistory.html?req_city=Cleveland&req_statename=Ohio",
      "https://www.wunderground.com/history/airport/KBFI/year/month/day/DailyHistory.html?req_city=Seattle&req_state=WA&req_statename=Washington&reqdb.zip=98101&reqdb.magic=1&reqdb.wmo=99999", "https://www.wunderground.com/history/airport/KMIA/year/month/day/DailyHistory.html?req_city=Miami&req_statename=Florida", "https://www.wunderground.com/history/airport/KJFK/year/month/day/DailyHistory.html?req_city=Queens&req_state=NY&req_statename=New+York&reqdb.zip=11427&reqdb.magic=4&reqdb.wmo=99999",
      "https://www.wunderground.com/history/airport/KDCA/year/month/day/DailyHistory.html?req_city=Washington&req_state=DC&req_statename=District+of+Columbia&reqdb.zip=20001&reqdb.magic=1&reqdb.wmo=99999", "https://www.wunderground.com/history/airport/KBWI/year/month/day/DailyHistory.html?req_city=Baltimore&req_state=MD&req_statename=Maryland&reqdb.zip=21201&reqdb.magic=1&reqdb.wmo=99999", "https://www.wunderground.com/history/airport/KSAN/year/month/day/DailyHistory.html?req_city=San%20Diego&req_statename=California",
      "https://www.wunderground.com/history/airport/KPNE/year/month/day/DailyHistory.html?req_city=Philadelphia&req_state=PA&req_statename=Pennsylvania&reqdb.zip=19019&reqdb.magic=1&reqdb.wmo=99999", "https://www.wunderground.com/history/airport/KAGC/year/month/day/DailyHistory.html?req_city=Pittsburgh&req_state=PA&req_statename=Pennsylvania&reqdb.zip=15122&reqdb.magic=2&reqdb.wmo=99999", "https://www.wunderground.com/history/airport/KGKY/year/month/day/DailyHistory.html?req_city=Arlington&req_statename=Texas",
      "https://www.wunderground.com/history/airport/KSPG/year/month/day/DailyHistory.html?req_city=Saint+Petersburg&req_state=FL&req_statename=Florida&reqdb.zip=33701&reqdb.magic=1&reqdb.wmo=99999", "https://www.wunderground.com/history/airport/KBOS/year/month/day/DailyHistory.html?req_city=Boston&req_state=MA&req_statename=Massachusetts&reqdb.zip=02101&reqdb.magic=1&reqdb.wmo=99999", "https://www.wunderground.com/history/airport/KLUK/year/month/day/DailyHistory.html?req_city=Cincinnati&req_state=OH&req_statename=Ohio&reqdb.zip=45201&reqdb.magic=1&reqdb.wmo=99999",
      "https://www.wunderground.com/history/airport/KAPA/year/month/day/DailyHistory.html?req_city=Denver&req_statename=Colorado", "https://www.wunderground.com/history/airport/KMKC/year/month/day/DailyHistory.html?req_city=Kansas+City&req_state=MO&req_statename=Missouri&reqdb.zip=64106&reqdb.magic=1&reqdb.wmo=99999", "https://www.wunderground.com/history/airport/KDET/year/month/day/DailyHistory.html?req_city=Detroit&req_state=MI&req_statename=Michigan&reqdb.zip=48201&reqdb.magic=1&reqdb.wmo=99999",
      "https://www.wunderground.com/history/airport/KMIC/year/month/day/DailyHistory.html?req_city=Minneapolis&req_state=MN&req_statename=Minnesota&reqdb.zip=55401&reqdb.magic=1&reqdb.wmo=99999", "https://www.wunderground.com/history/airport/KMDW/year/month/day/DailyHistory.html?req_city=Chicago&req_state=IL&req_statename=Illinois&reqdb.zip=60290&reqdb.magic=1&reqdb.wmo=99999", "https://www.wunderground.com/history/airport/KHPN/year/month/day/DailyHistory.html?req_city=Bronxville&req_state=NY&req_statename=New+York&reqdb.zip=10708&reqdb.magic=1&reqdb.wmo=99999",
      "https://www.wunderground.com/history/airport/KOPF/year/month/day/DailyHistory.html?req_city=Opa%20Locka&req_state=FL&reqdb.zip=33056&reqdb.magic=1&reqdb.wmo=99999", "https://www.wunderground.com/history/airport/KSPG/year/month/day/DailyHistory.html?req_city=Saint+Petersburg&req_state=FL&req_statename=Florida&reqdb.zip=33701&reqdb.magic=1&reqdb.wmo=99999", "https://www.wunderground.com/history/airport/CWTA/2016/05/20/DailyHistory.html?req_city=Montreal&req_statename=Quebec&reqdb.zip=00000&reqdb.magic=20&reqdb.wmo=71612"]

end
