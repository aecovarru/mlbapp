require 'rails_helper'

RSpec.describe Batter, type: :model do
  it do
    should belong_to :owner
    should belong_to :player
    should belong_to :team
    should have_many :batter_stats
  end
end
