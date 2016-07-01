class Player < ApplicationRecord
  validates_presence_of  :name, :identity
  has_many   :batters
  has_many   :pitchers

  def first_name
    name[0...name.rindex(" ")]
  end

  def last_name
    name[name.rindex(" ")+1..-1]
  end
end
