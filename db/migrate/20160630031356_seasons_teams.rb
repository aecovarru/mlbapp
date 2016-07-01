class SeasonsTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :seasons_teams, id: false do |t|
      t.belongs_to :season, index: true
      t.belongs_to :team, index: true
    end
  end
end
