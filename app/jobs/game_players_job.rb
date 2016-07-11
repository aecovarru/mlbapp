class GamePlayersJob < ApplicationJob
  queue_as :default
  include Download
  def perform(*args)
    # Do something later
    if args[0].respond_to?(:each)
      args[0].each do |game|
        run(game)
      end
    else
      run(args[0])
    end
  end

  private

    def run(game)
      url = "http://www.baseball-reference.com/boxes/#{game.home_team.alt_abbr}/#{game.url}.shtml"
      puts url
      doc = nil
      until doc
        doc = download_document(url)
      end
      create_players(doc, game)
    end

    def create_players(doc, game)
      create_batters(doc, game)
      create_pitchers(doc, game)
    end

    def create_batters(doc, game)
      teams = [game.away_team, game.home_team]
      teams.each do |team|
        puts team.name
        css = "##{team.css}batting tbody td:nth-child(1)"
        lineup = 0
        elements = doc.css(css)
        puts "BUG!!!" if elements.size == 0
        elements.each do |element|
          break if element.text.size == 0
          name, identity = batter_identity(element)
          player = Player.find_by(name: name, identity: identity)
          batter = Batter.find_or_create_by(player: player, owner: game, team: team)
          starter = is_batter_starter?(element)
          lineup += 1 if starter
          batter.update(starter: starter, lineup: lineup)
        end
      end
    end

    def create_pitchers(doc, game)
      teams = [game.away_team, game.home_team]
      teams.each do |team|
        doc.css("##{team.css}pitching tbody td:nth-child(1)").each_with_index do |element, index|
          name, identity = pitcher_identity(element)
          player = Player.find_by(name: name, identity: identity)
          pitcher = Pitcher.find_or_create_by(player: player, owner: game, team: team)
          pitcher.update(starter: is_pitcher_starter?(index))
        end
      end
    end

    def batter_identity(element)
      child = get_child(element)
      name = child.text
      identity = get_identity(child)
      return name, identity
    end

    def pitcher_identity(element)
      child = element.child
      name = child.text
      identity = get_identity(child)
      return name, identity
    end

    def get_identity(child)
      href = child['href']
      href[11...href.rindex(".")]
    end

    def is_batter_starter?(element)
      element.children.size == 2
    end

    def is_pitcher_starter?(index)
      index == 0
    end

    def get_child(element)
      children = element.children
      if children.size == 3
        children[1]
      elsif children.size == 2
        children[0]
      end
    end
end