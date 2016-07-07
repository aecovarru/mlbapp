namespace :setup do

  task test: :environment do

    games = Game.all[0..4]
    games.each do |game|
      TimeJob.perform_now(game)
    end

  end

end