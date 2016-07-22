class SeasonsController < ApplicationController
  def index
    @season_props = { seasons: Season.all, name: "HI" }
  end
end
