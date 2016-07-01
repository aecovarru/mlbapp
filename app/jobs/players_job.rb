class PlayersJob < ApplicationJob
  queue_as :default
  include Download
  def perform(*args)
    Season.all.each do |season|
      season.teams.each do |team|
        create_players(season, team)
      end
    end
  end

  private

    def create_players(season, team)
      doc = get_team_document(season, team)
      create_pitchers(doc, season, team)
      create_batters(doc, season, team)
      doc = get_roster_document(season, team)
      update_handedness(doc, season)
    end

    def get_team_document(season, team)
      url = "http://www.baseball-reference.com/teams/#{team.abbr}/#{season.year}.shtml"
      puts url
      download_document(url)
    end

    def create_batters(doc, season, team)
      doc.css("#team_batting tbody td:nth-child(3)").each do |element|
        player = find_player(element)
        Batter.find_or_create_by(player: player, owner: season, team: team)
      end
    end

    def create_pitchers(doc, season, team)
      doc.css("#team_pitching tbody td:nth-child(3)").each do |element|
        player = find_player(element)
        Pitcher.find_or_create_by(player: player, owner: season, team: team)
      end
    end

    def get_roster_document(season, team)
      url = "http://www.baseball-reference.com/teams/#{team.abbr}/#{season.year}-roster.shtml"
      puts url
      download_document(url)
    end

    def update_handedness(doc, season)
      player = nil
      doc.css("#appearances td").each_slice(get_index(season)) do |slice|
        player = find_player(slice[0])
        bathand = slice[3].text
        throwhand = slice[4].text
        player.update(bathand: bathand, throwhand: throwhand)
      end
    end

    def get_index(season)
      season.year == Time.now.year ? 28 : 29
    end

    def get_identity(player)
      unless player['href']
        player = player.child
      end
      href = player['href']
      href[11...href.rindex(".")]
    end

    def find_player(element)
      player_params = player_info(element)
      Player.find_or_create_by(player_params)
    end

    def player_info(element)
      name = get_name(element)
      return { name: name, abbr: convert_name_to_abbr(name), identity: get_identity(element.child) }
    end

    def convert_name_to_abbr(name)
      last_name = name[name.rindex(" ")+1..-1]
      name[0] + ". " + last_name
    end

    def get_name(player)
      player.child.text
    end
end
