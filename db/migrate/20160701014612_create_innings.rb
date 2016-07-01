class CreateInnings < ActiveRecord::Migration[5.0]
  def change
    create_table :innings do |t|
      t.references :game,  index: true, foreign_key: true
      t.integer    :num
    end
  end
end
