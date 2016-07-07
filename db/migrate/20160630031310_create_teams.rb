class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.string  :name
      t.string  :abbr
      t.string  :alt_abbr
      t.integer :fangraph_id
      t.string  :city
      t.string  :stadium
      t.string  :league
      t.string  :division
      t.string  :zipcode
      t.integer :timezone
    end
  end
end
