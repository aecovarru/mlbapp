class GamesJob < ApplicationJob
  queue_as :default
  include Download
  def perform(*args)
    if args[0].respond_to?(:each)
      args[0].each do |season|
        season.teams.each do |team|
          create_games(season, team)
        end
      end
    else
      args[0].teams.each do |team|
        create_games(args[0], team)
      end
    end
  end

  private
    def create_games(season, team)
      url = "http://www.baseball-reference.com/teams/#{team.abbr}/#{season.year}-schedule-scores.shtml"
      puts url
      doc = download_document(url)

      doc.css("#team_schedule td").each_slice(21) do |slice|
        next if post_season?(slice[0])
        break if slice[9].text.empty?
        date = find_date(slice[2])
        game_date = GameDate.find_or_create_by(date: date, season: season)
        away_team, home_team = find_away_and_home_teams(slice[4], slice[5], slice[6])
        num = find_game_num(slice[2])
        game = Game.find_or_create_by(season: season, game_date: game_date, away_team: away_team, home_team: home_team, num: num)
        puts game.url
      end
    end

    def find_date(date_element)
      href = date_element.child['href']
      Date.parse(href[-10..-1])
    end

    def find_away_and_home_teams(team1, home_or_away, team2)
      team1 = Team.find_by_abbr(team1.text)
      team2 = Team.find_by_abbr(team2.text)
      if home_or_away.text.empty?
        return team2, team1
      else
        return team1, team2
      end
    end

    def find_game_num(date_element)
      children = date_element.children
      children.size == 1 ? 0 : children.last.to_s[-2].to_i
    end

    def post_season?(element)
      element.text.empty?
    end
end
