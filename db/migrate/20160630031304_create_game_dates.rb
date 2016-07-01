class CreateGameDates < ActiveRecord::Migration[5.0]
  def change
    create_table :game_dates do |t|
      t.references :season, index: true, foreign_key: true
      t.date       :date
    end
  end
end
