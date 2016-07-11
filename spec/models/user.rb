require "rails_helper"

RSpec.describe User, :type => :model do
  it "name is less than 50 characters" do
    boolean = User.create(name: "A"*51)
    expect(boolean).to eq(false)
  end
end