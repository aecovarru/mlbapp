# TeamsJob.perform_now
# SeasonsJob.perform_now
# GamesJob.perform_now
# PlayersJob.perform_now
# GamePlayersJob.perform_now(Game.all)
# PlayerStatJob.perform_now(Game.all)
# TimeJob.perform_now(Game.all)
# WeatherJob.perform_now(Game.all)
Game.all.each do |game|
  if game.weathers.size == 0
    WeatherJob.perform_now(game)
  end
end
# BettingJob.perform_now(GameDate.all)
