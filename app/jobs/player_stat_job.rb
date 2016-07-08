class PlayerStatJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    if args[0].respond_to?(:each)
      args[0].each do |game|
        PlayByPlay::Parse.new(game).run
      end
    else
      PlayByPlay::Parse.new(args[0]).run
    end
  end
end
