require 'rails_helper'

RSpec.describe Season, type: :model do
  it do
    should validate_presence_of :year
    should have_and_belong_to_many :teams
    should have_many :game_dates 
    should have_many :games
    should have_many :pitchers
    should have_many :batters
  end
end
