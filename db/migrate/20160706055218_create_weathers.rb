class CreateWeathers < ActiveRecord::Migration[5.0]
  def change
    create_table :weathers do |t|
      t.references :game, index: true, foreign_key: true
      t.integer :hour
      t.float :temp
      t.float :dew
      t.float :pressure
      t.float :humidity
      t.string :wind_dir
      t.float :wind_speed
      t.float :air_density
      t.float :precip
    end
  end
end
