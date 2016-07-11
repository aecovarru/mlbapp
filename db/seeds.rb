# TeamsJob.perform_now
# SeasonsJob.perform_now
# GamesJob.perform_now(Season.all)
# TimeJob.perform_now(Game.all)
# PlayersJob.perform_now(Season.all)
# GamePlayersJob.perform_now(Game.all)
Season.where("id > 5").each do |season|
  PlayerStatJob.perform_now(season.games)
end
WeatherJob.perform_now(Game.all)
BettingJob.perform_now(GameDate.all)