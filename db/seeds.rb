# TeamsJob.perform_now
# SeasonsJob.perform_now
# GamesJob.perform_now
# PlayersJob.perform_now
# GamePlayersJob.perform_now(Game.all)
# PlayerStatJob.perform_now(Game.all)
# TimeJob.perform_now(Game.all)
# WeatherJob.perform_now(Game.all)
# BettingJob.perform_now(GameDate.all)
GameDate.all.each do |game_date|
  next if game_date.games.where(away_total: "").size == 0
  BettingJob.perform_now(game_date)
end
