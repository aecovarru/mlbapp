class CreatePitchers < ActiveRecord::Migration[5.0]
  def change
    create_table :pitchers do |t|
      t.references :player,  index: true, foreign_key: true
      t.references :team,  index: true, foreign_key: true
      t.references :owner,  index: true, polymorphic: true
      t.string     :owner_type
      t.boolean    :starter, default: false
    end
  end
end
