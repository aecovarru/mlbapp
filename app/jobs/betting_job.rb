class BettingJob < ApplicationJob
  queue_as :default

  include Download
  def perform(*args)
    # Do something later
    if args[0].respond_to?(:each)
      args[0].each do |game_date|
        get_lines(game_date)
      end
    else
      get_lines(args[0])
    end
  end

  private

    def get_lines(game_date)
      @game_date = game_date
      date = @game_date.date
      date_url = "%d%02d%02d" % [date.year, date.month, date.day]
      url = "http://www.sportsbookreview.com/betting-odds/mlb-baseball/?date=" + date_url 
      puts url
      doc = download_document(url)
      return if doc.css(".team-name a").size == 0
      game_array = get_games(doc, game_date)
      away_money_lines, home_money_lines = money_line(doc)
      away_totals, home_totals = totals(date_url)
      (0...game_array.size).each do |i|
        if game_array[i]
          puts game_array[i].id
          puts "#{away_totals[i]} #{home_totals[i]} #{away_money_lines[i]} #{home_money_lines[i]}"
          game_array[i].update(away_total: away_totals[i], home_total: home_totals[i],
          away_money_line: away_money_lines[i], home_money_line: home_money_lines[i])
        end
      end
    end

    def get_games(doc, game_date)
      games = @game_date.games
      game_array = Array.new
      doc.css(".team-name a").each_slice(2) do |slice|
        away_team = Team.find_by_abbr(get_abbr(slice[0]))
        home_team = Team.find_by_abbr(get_abbr(slice[1]))
        game_array << find_game(game_array, games, away_team, home_team)
      end
      return game_array
    end

    def money_line(doc)
      away_money_lines = Array.new
      home_money_lines = Array.new
      doc.css(".eventLine-consensus+ .eventLine-book b").each_slice(2) do |slice|
        away_money_lines << slice[0].text
        home_money_lines << slice[1].text
      end
      return away_money_lines, home_money_lines
    end

    def totals(date_url)
      url = "http://www.sportsbookreview.com/betting-odds/mlb-baseball/totals/?date=" + date_url
      doc = download_document(url)
      away_totals = Array.new
      home_totals = Array.new
      doc.css(".eventLine-consensus+ .eventLine-book b").each_slice(2) do |slice|
        away_totals << slice[0].text
        home_totals << slice[1].text
      end
      return away_totals, home_totals
    end

    def get_abbr(element)
      abbr = element.child.text
      if abbr.size > 3
        abbr = abbr[0...-3]
      end
      fix_abbr(abbr)
    end

    def fix_abbr(abbr)
      year = @game_date.date.year
      case abbr
      when "TB"
        if year < 2008
          "TBD"
        else
          "TBR"
        end
      when "LA"
        "LAD"
      when "SF"
        "SFG"
      when "SD"
        "SDP"
      when "CWS"
        "CHW"
      when "KC"
        "KCR"
      when "WSH"
        "WSN"
      when "MIA"
        if year < 2012
          abbr
        else
          "FLA"
        end
      else
        abbr
      end
    end

    def find_game(game_array, games, away_team, home_team)
      games = games.where(away_team: away_team, home_team: home_team)
      if games.size == 2
        if game_array.include?(games.first)
          games.second
        else
          games.first
        end
      elsif games.size == 1
        games.first
      else
        nil
      end  
    end


end
