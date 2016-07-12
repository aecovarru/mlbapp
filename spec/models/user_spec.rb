require 'rails_helper'

RSpec.describe User, type: :model do
  it do
    should validate_length_of(:name).
      is_at_most(50)
    should validate_length_of(:password).
      is_at_least(6)
    should validate_presence_of(:name)
  end
end
