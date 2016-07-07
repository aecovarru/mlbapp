class TimeJob < ApplicationJob
  queue_as :default

  include Download
  def perform(*args)
    # Do something later
    if args[0].respond_to?(:each)
      args[0].each do |game|
        get_time(game)
      end
    else
      get_time(args[0])
    end
  end

  private

    def get_time(game)
      
      home_team = game.home_team
      url = "http://www.baseball-reference.com/boxes/#{home_team.alt_abbr}/#{game.url}.shtml"
      doc = download_document(url)
      puts url

      scores = doc.css(".xxx_large_text")
      away_score = scores[0].text.to_i
      home_score = scores[1].text.to_i
      game.update(away_score: away_score, home_score: home_score)

      element = doc.css("#page_content .float_left")[0]
      text = element.text.strip
      index = text.index(":")
      return unless index

      if text[index-2].to_i == 0
        time = text[index-1..-1]
        hour = text[index-1...index].to_i
      else
        time = text[index-2..-1]
        hour = text[index-2...index].to_i
      end

      time = time.upcase

      hour += 12 if time[-2..-1] == "PM"
      hour += home_team.timezone

      game.update(hour: hour, time: time)

      puts game.id
      puts "#{hour} #{time}"
      puts "#{away_score} #{home_score}"
    end

end
