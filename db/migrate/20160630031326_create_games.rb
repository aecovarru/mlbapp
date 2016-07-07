class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.references :season,  index: true, foreign_key: true
      t.references :game_date,  index: true, foreign_key: true
      t.references :away_team, index: true
      t.references :home_team, index: true
      t.integer    :num,       default: 0
      t.integer    :hour,      default: 0
      t.string     :away_money_line, default: ""
      t.string     :home_money_line, default: ""
      t.string     :away_total,      default: ""
      t.string     :home_total,      default: ""
    end
  end
end
