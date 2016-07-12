require 'rails_helper'

RSpec.describe GameDate, type: :model do
  it { should belong_to(:season) }
  it { should have_many(:games) }
end
