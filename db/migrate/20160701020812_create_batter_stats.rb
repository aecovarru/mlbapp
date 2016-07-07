class CreateBatterStats < ActiveRecord::Migration[5.0]
  def change
    create_table :batter_stats do |t|
      t.references :batter,  index: true, foreign_key: true
      t.string     :handed,  default: ""
      t.integer    :ubb,     default: 0
      t.integer    :ibb,   default: 0
      t.integer    :hbp,   default: 0
      t.integer    :single,  default: 0
      t.integer    :double,  default: 0
      t.integer    :triple,  default: 0
      t.integer    :homerun, default: 0
      t.integer    :fb,    default: 0
      t.integer    :ld,    default: 0
      t.integer    :gb,    default: 0
      t.integer    :ab,    default: 0
      t.integer    :pa,    default: 0
      t.integer    :k,     default: 0
      t.integer    :sac_bunt,    default: 0
      t.integer    :sac_fly,    default: 0
    end
  end
end
