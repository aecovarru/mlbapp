class HelloWorldController < ApplicationController
  def index
    season = Season.first
    @game_props = { teams: season.teams, games: season.games.includes(:game_date).order("game_dates.date DESC") }
    @hello_world_props = { name: "Stranger" }
  end
end
