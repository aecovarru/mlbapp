module PlayByPlay
  class Accuracy

    include Download
    attr_reader :game

    def initialize(game)
      @game = game
    end

    def check
      home_team = game.home_team
      url = "http://www.baseball-reference.com/boxes/#{home_team.alt_abbr}/#{game.url}.shtml"
      puts url
      puts game.id
      doc = download_document(url)
      check_batters(doc)
      check_pitchers(doc)
    end

    private

      def check_batters(doc)
        doc.css("##{game.away_team.css}batting tbody td, ##{game.home_team.css}batting tbody td").each_slice(22) do |slice|
          break if slice[0].text.size == 0
          batter_stat = find_batter(slice[0])
          next unless batter_stat
          check_batter_attributes(batter_stat, slice)
        end
      end

      def check_batter_attributes(batter_stat, slice)
        name = batter_stat.batter.name
        print_error(name, "ab", batter_stat.ab, slice[1].text.to_i)
        print_error(name, "h", batter_stat.h, slice[3].text.to_i)
        print_error(name, "bb", batter_stat.bb, slice[5].text.to_i)
        print_error(name, "k", batter_stat.k, slice[6].text.to_i)
        print_error(name, "pa", batter_stat.pa, slice[7].text.to_i)
      end

      def find_batter(element)
        name, identity = batter_identity(element)
        player = Player.find_by(name: name, identity: identity)
        batter = Batter.find_by(player: player, owner: game)
        batter.batter_stats.first
      end

      def batter_identity(element)
        child = get_child(element)
        name = child.text
        identity = get_identity(child)
        return name, identity
      end

      def check_pitchers(doc)
        doc.css("##{game.away_team.css}pitching tbody td, ##{game.home_team.css}pitching tbody td").each_slice(25) do |slice|
          pitcher_stat = find_pitcher(slice[0])
          check_pitcher_attributes(pitcher_stat, slice)
        end
      end

      def check_pitcher_attributes(pitcher_stat, slice)
        name = pitcher_stat.pitcher.name
        print_error(name, "ip", pitcher_stat.ip, slice[1].text.to_f)
        print_error(name, "h", pitcher_stat.h, slice[2].text.to_i)
        print_error(name, "r", pitcher_stat.r, slice[3].text.to_i)
        # print_error(name, "er", pitcher_stat.er, slice[4].text.to_i)
        print_error(name, "bb", pitcher_stat.bb, slice[5].text.to_i)
        print_error(name, "k", pitcher_stat.k, slice[6].text.to_i)
        print_error(name, "homerun", pitcher_stat.homerun, slice[7].text.to_i)
        print_error(name, "gb", pitcher_stat.gb, slice[15].text.to_i)
        print_error(name, "fb", pitcher_stat.fb, slice[16].text.to_i)
        print_error(name, "ld", pitcher_stat.ld, slice[17].text.to_i)
      end

      def find_pitcher(element)
        name, identity = pitcher_identity(element)
        player = Player.find_by(name: name, identity: identity)
        pitcher = Pitcher.find_by(player: player, owner: game)
        pitcher.pitcher_stats.first
      end

      def pitcher_identity(element)
        child = element.child
        name = child.text
        identity = get_identity(child)
        return name, identity
      end

      def get_child(element)
        children = element.children
        if children.size == 3
          children[1]
        elsif children.size == 2
          children[0]
        end
      end

      def get_identity(child)
        href = child['href']
        href[11...href.rindex(".")]
      end

      def print_error(name, stat_name, stat, expected)
        unless stat == expected
          puts "#{name} #{stat_name} wrong: expected #{expected}; received #{stat}"
        end
      end

  end
end