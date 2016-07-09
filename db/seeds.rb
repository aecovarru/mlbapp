# TeamsJob.perform_now
# SeasonsJob.perform_now
# GamesJob.perform_now(Season.all)
# TimeJob.perform_now(Game.all)
# PlayersJob.perform_now(Season.all)
# GamePlayersJob.perform_now(Game.all)
# PlayerStatJob.perform_now(Game.all)
# WeatherJob.perform_now(Season.find_by_year(2016).games)
# BettingJob.perform_now(GameDate.all)
WeatherJob.perform_now(Game.find(842))