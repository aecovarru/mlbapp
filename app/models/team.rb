class Team < ApplicationRecord
  has_and_belongs_to_many :seasons
  has_many :games
  def css
    city = id == 1 ? "Anaheim" : self.city
    "#{city}#{name}".gsub(/\s+/, "")
  end
end
