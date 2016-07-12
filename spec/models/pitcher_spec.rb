require 'rails_helper'

RSpec.describe Pitcher, type: :model do
  it do
    should belong_to :owner
    should belong_to :player
    should belong_to :team
    should have_many :pitcher_stats
  end
end
