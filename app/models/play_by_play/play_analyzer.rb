module PlayByPlay
  class PlayAnalyzer

    def hit_event(plays)
      get_hit_event(plays.first)
    end

    def hit_type(plays)
      get_hit_type(plays.first)
    end

    def runs(plays)
      get_runs(plays)
    end

    def steals(plays)
      plays.inject(0) {|memo, play| /steals/i =~ play ? 1 +  memo : memo }
    end

    def pitches_thrown(pitches)
      thrown = pitches[0...pitches.index(",")].to_i
      balls = pitches[pitches.index("(")+1].to_i
      strikes = thrown - balls
    end

    private

      def get_hit_event(hit_event)
        if /sacrifice fly/i =~ hit_event
          :sac_fly
        elsif /sacrifice/i =~ hit_event
          :sac_bunt
        elsif /intentional walk/i =~ hit_event
          :ibb
        elsif /walk/i =~ hit_event && (hit_event.size == 4 || hit_event[5].index(" "))
          :ubb
        elsif /hit by pitch/i =~ hit_event
          :hbp
        elsif /strike/i =~ hit_event
          :k
        elsif /double play/i =~ hit_event
          :double_play
        elsif /single/i =~ hit_event
          :single
        elsif /double/i =~ hit_event
          :double
        elsif /triple/i =~ hit_event
          :triple
        elsif /interference/i =~ hit_event
          :interference
        elsif /home run/i =~ hit_event
          :homerun
        elsif /reached/i =~ hit_event
          :reached
        elsif /passed ball/i =~ hit_event || /baserunner out/i =~ hit_event
        elsif /fielder/i =~ hit_event
          :choice
        elsif /out/i =~ hit_event || /ball/i =~ hit_event || /pop/i =~ hit_event
          :outs
        end
      end

      def get_hit_type(hit_event)
        if !(/bunt/i=~ hit_event) && (/line drive/i =~ hit_event || /lineout/i =~ hit_event)
          :ld
        elsif (/ground/i =~ hit_event && !(/ground-rule/i =~ hit_event)) || (/bunt/i =~ hit_event && !(/strikeout/i =~ hit_event)) || /fielder/i =~ hit_event
          :gb
        elsif /fly/i =~ hit_event
          :fb
        end
      end

      def get_runs(plays)
        r = er = 0
        if get_hit_event(plays.first) == :homerun
          r  += 1
          er += 1
        end
        plays[1..-1].each do |play|
          if /uner/i =~ play
            r += 1
          elsif /scores/i =~ play
            r += 1
            er += 1
          end
        end
        return r, er
      end

  end
end