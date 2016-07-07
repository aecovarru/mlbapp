class GamesController < ApplicationController

  def index
    @season = Season.find(params[:season_id])
    @games = @season.games.includes(:game_date).order("game_dates.date DESC")
    @teams = @season.teams
  end

  def show
    @season = Season.find(params[:season_id])
    @game = Game.find(params[:id])
  end
  
end
