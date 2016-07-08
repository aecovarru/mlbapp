TeamsJob.perform_now
SeasonsJob.perform_now
GamesJob.perform_now(Season.all)
TimeJob.perform_now(Game.all)
PlayersJob.perform_now(Season.all)
GamePlayersJob.perform_now(Game.all)
# PlayerStatJob.perform_now(Game.all)
# WeatherJob.perform_now(Game.all)
# BettingJob.perform_now(GameDate.all)
