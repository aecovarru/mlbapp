class AddTime < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :time, :string, default: ""
    add_column :games, :away_score, :integer, default: 0
    add_column :games, :home_score, :integer, default: 0
  end
end
