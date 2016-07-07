module PlayByPlay
  class Parse

    include Download
    attr_reader :game

    def initialize(game)
      @game = game
      @pitcher_ids = game.pitchers.map{ |pitcher| pitcher.player_id }
      @batter_ids = game.batters.map{ |batter| batter.player_id }
      @pitch_counts = Array.new
      @runs_outs = Array.new
      @batters = Array.new
      @pitchers = Array.new
      @plays = Array.new
    end

    def run
      away_team = game.away_team
      home_team = game.home_team
      url = "http://www.baseball-reference.com/boxes/#{home_team.alt_abbr}/#{game.url}.shtml"
      puts url
      puts game.id
      doc = download_document(url)
      return unless doc

      doc.css("#play_by_play td").each do |element|
        if new_inning(element)
          create_inning(element)
          clear_arrays
          next
        end

        if @index%12 == 0 || @valid_row
          fill_arrays(element)
        end

        if @index%12 == 9 && !@valid_row
          @index += 2
        end

        @index += 1
      end
      InningBuilder.new(@inning, @runs_outs, @batters, @pitchers, @plays).create

      create_game_batter_stats
      create_game_pitcher_stats
    end

    private

      def create_inning(element)
        if @inning
          InningBuilder.new(@inning, @runs_outs, @batters, @pitchers, @plays).create
        end
        num = inning_num(element.text)
        @inning = Inning.find_or_create_by(game: game, num: num)
        @index = 0
      end

      def fill_arrays(element)
        text = element.text
        case @index%12
        when 0
          @valid_row = is_valid_row?(text)
        when 5
          @runs_outs << text
        when 7
          @batters << find_batter(element)
        when 8
          @pitchers << find_pitcher(element)
        when 11
          @plays << text
        end
      end

      def clear_arrays
        @pitch_counts.clear
        @runs_outs.clear
        @batters.clear
        @pitchers.clear
        @plays.clear
      end

      def new_inning(element)
        text = element.text
        if text[0..2] == "Top"
          @pitcher_team = game.home_team
          @batter_team  = game.away_team
        elsif text[0..2] == "Bot"
          @pitcher_team = game.away_team
          @batter_team = game.home_team
        else
          return false
        end
        return true
      end

      def inning_num(text)
        text.match(/\w+,/).to_s.match(/\d+/).to_s.to_i
      end

      def is_valid_row?(text)
        text.size > 0
      end

      def find_batter(element)
        abbr = get_abbr(element)
        player = Player.find_by(abbr: abbr, id: @batter_ids)
        Batter.find_or_create_by(player: player, owner: @inning, team: @batter_team)
      end

      def find_pitcher(element)
        abbr = get_abbr(element)
        player = Player.find_by(abbr: abbr, id: @pitcher_ids)
        Pitcher.find_or_create_by(player: player, owner: @inning, team: @pitcher_team)
      end

      def get_abbr(element)
        element.text.gsub("\u00A0", " ")
      end

      def create_game_batter_stats
        inning_batters = Batter.where(owner: game.innings)
        @batter_ids.each do |player_id|
          game_batter = game.batters.find_by(player_id: player_id)
          player_batters = inning_batters.where(player_id: player_id)
          next if player_batters.empty?
          attributes = player_batters.map {|batter| batter.batter_stats.first.attributes}
          attributes.each do |attribute|
            attribute.delete("id")
            attribute.delete("batter_id")
            attribute.delete("handed")
          end
          game_batter_stat = BatterStat.find_or_create_by(batter: game_batter)
          game_attributes = combine_array_of_hashes(attributes)
          game_batter_stat.update(game_attributes)
        end
      end

      def create_game_pitcher_stats
        inning_pitchers = Pitcher.where(owner: game.innings)
        @pitcher_ids.each do |player_id|
          game_pitcher = game.pitchers.find_by(player_id: player_id)
          attributes = inning_pitchers.where(player_id: player_id).map {|pitcher| pitcher.pitcher_stats.first.attributes}
          attributes.each do |attribute|
            attribute.delete("id")
            attribute.delete("pitcher_id")
            attribute.delete("handed")
          end
          game_pitcher_stat = PitcherStat.find_or_create_by(pitcher: game_pitcher)
          next if attributes.empty?
          game_attributes = combine_array_of_hashes(attributes)
          game_pitcher_stat.update(game_attributes)
        end
      end

      def combine_array_of_hashes(attributes)
        attributes.inject {|memo, hash| memo.merge(hash) {|key, a, b| a + b}}
      end

  end
end