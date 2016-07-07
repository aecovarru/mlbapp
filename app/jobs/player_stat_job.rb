class PlayerStatJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    games = args[0]
    games.each do |game|
      PlayByPlay::Parse.new(game).run
    end
  end
end
