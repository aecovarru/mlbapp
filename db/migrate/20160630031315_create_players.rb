class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.string  :name,        default: ""
      t.string  :identity,    default: ""
      t.string  :abbr,        default: ""
      t.string  :bathand,     default: ""
      t.string  :throwhand,   default: ""
    end
  end
end
