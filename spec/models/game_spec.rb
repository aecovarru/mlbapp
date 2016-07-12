require 'rails_helper'

RSpec.describe Game, type: :model do
  it { should belong_to(:season) }
  it { should belong_to(:game_date) }
  it { should belong_to(:away_team) }
  it { should belong_to(:home_team) }
  it { should have_many(:pitchers) }
  it { should have_many(:batters) }
  it { should have_many(:weathers) }
  it { should have_many(:innings) }
end
