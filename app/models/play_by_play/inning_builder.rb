module PlayByPlay
  class InningBuilder

    def initialize(inning, runs_outs, batters, pitchers, plays)
      @inning  = inning
      @runs_outs = runs_outs
      @batters  = batters
      @pitchers = pitchers
      @batter_hash  = initialize_batter_hash(batters)
      @pitcher_hash = initialize_pitcher_hash(pitchers)
      @plays = plays
      @analyzer = PlayAnalyzer.new
      @bases = Hash.new(OpenStruct.new)
    end

    def create
      (0...@plays.size).each do |i|
        
        plays = @plays[i].split(";")
        hit_event = @analyzer.hit_event(plays)
        hit_type = @analyzer.hit_type(plays)
        outs = @runs_outs[i].scan(/O/).count
        runs = @runs_outs[i].scan(/R/).count
        steals = @analyzer.steals(plays)

        batter_stat_hash = @batter_hash[@batters[i].id]
        pitcher_stat_hash = @pitcher_hash[@pitchers[i].id]

        add_event_to_pitcher_hash(pitcher_stat_hash, hit_event)
        add_event_to_batter_hash(batter_stat_hash, hit_event)
        add_type_to_hash(pitcher_stat_hash, hit_type)
        add_type_to_hash(batter_stat_hash, hit_type)
        pitcher_stat_hash[:outs] += outs
        pitcher_stat_hash[:r] += runs
        pitcher_stat_hash[:sb] += steals

      end
      save_batter_stats
      save_pitcher_stats
    end

    private

      def initialize_batter_hash(batters)
        batter_hash = Hash.new
        batters.each do |batter|
          batter_hash[batter.id] = {ubb: 0, ibb: 0, hbp: 0, single: 0, double: 0, triple: 0, homerun: 0, fb: 0, ld: 0, gb: 0, sac_fly: 0, sac_bunt: 0, ab: 0, pa: 0, k: 0}
        end
        return batter_hash
      end

      def initialize_pitcher_hash(pitchers)
        pitcher_hash = Hash.new
        pitchers.each do |pitcher|
          pitcher_hash[pitcher.id] = {ubb: 0, ibb: 0, hbp: 0, single: 0, double: 0, triple: 0, homerun: 0, fb: 0, ld: 0, gb: 0, outs: 0, r: 0, er: 0, k: 0, sb: 0}
        end
        return pitcher_hash
      end

      def add_event_to_pitcher_hash(hash, event)
        if event
          unless not_pitcher_event?(event)
            hash[event] += 1
          end
        end
      end

      def add_event_to_batter_hash(hash, event)
        if event
          hash[:pa] += 1
          unless not_batter_event?(event)
            hash[event] += 1
          end
          if is_ab?(event)
            hash[:ab] += 1
          end
        end
      end

      def add_type_to_hash(hash, event)
        if event
          if event == :ld
            hash[:fb] += 1
          end
          hash[event] += 1
        end
      end

      def is_ab?(event)
        event == :single || event == :double || event == :triple || event == :homerun || event == :k || event == :outs || event == :double_play || event == :choice || event == :reached
      end

      def not_pitcher_event?(event)
        event == :outs || event == :double_play || event == :sac_fly || event == :sac_bunt || event == :choice || event == :reached || event == :interference
      end

      def not_batter_event?(event)
        event == :outs || event == :double_play || event == :choice || event == :reached || event == :interference
      end

      def save_batter_stats
        @batter_hash.each do |key, value|
          batter_stat = BatterStat.find_or_create_by(batter_id: key)
          batter_stat.update(value)
        end
      end

      def save_pitcher_stats
        @pitcher_hash.each do |key, value|
          pitcher_stat = PitcherStat.find_or_create_by(pitcher_id: key)
          pitcher_stat.update(value)
        end
      end

  end
end