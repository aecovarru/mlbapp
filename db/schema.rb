# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160701020812) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "batter_stats", force: :cascade do |t|
    t.integer "batter_id"
    t.string  "handed",    default: ""
    t.integer "ubb",       default: 0
    t.integer "ibb",       default: 0
    t.integer "hbp",       default: 0
    t.integer "single",    default: 0
    t.integer "double",    default: 0
    t.integer "triple",    default: 0
    t.integer "homerun",   default: 0
    t.integer "fb",        default: 0
    t.integer "ld",        default: 0
    t.integer "gb",        default: 0
    t.integer "ab",        default: 0
    t.integer "pa",        default: 0
    t.integer "k",         default: 0
    t.integer "sac_bunt",  default: 0
    t.integer "sac_fly",   default: 0
    t.index ["batter_id"], name: "index_batter_stats_on_batter_id", using: :btree
  end

  create_table "batters", force: :cascade do |t|
    t.integer "player_id"
    t.integer "team_id"
    t.string  "owner_type"
    t.integer "owner_id"
    t.boolean "starter",    default: false
    t.integer "lineup",     default: 0
    t.string  "position",   default: ""
    t.index ["owner_type", "owner_id"], name: "index_batters_on_owner_type_and_owner_id", using: :btree
    t.index ["player_id"], name: "index_batters_on_player_id", using: :btree
    t.index ["team_id"], name: "index_batters_on_team_id", using: :btree
  end

  create_table "game_dates", force: :cascade do |t|
    t.integer "season_id"
    t.date    "date"
    t.index ["season_id"], name: "index_game_dates_on_season_id", using: :btree
  end

  create_table "games", force: :cascade do |t|
    t.integer "season_id"
    t.integer "game_date_id"
    t.integer "away_team_id"
    t.integer "home_team_id"
    t.integer "num",          default: 0
    t.integer "hour",         default: 0
    t.index ["away_team_id"], name: "index_games_on_away_team_id", using: :btree
    t.index ["game_date_id"], name: "index_games_on_game_date_id", using: :btree
    t.index ["home_team_id"], name: "index_games_on_home_team_id", using: :btree
    t.index ["season_id"], name: "index_games_on_season_id", using: :btree
  end

  create_table "innings", force: :cascade do |t|
    t.integer "game_id"
    t.integer "num"
    t.index ["game_id"], name: "index_innings_on_game_id", using: :btree
  end

  create_table "pitcher_stats", force: :cascade do |t|
    t.integer "pitcher_id"
    t.string  "handed",     default: ""
    t.integer "ubb",        default: 0
    t.integer "ibb",        default: 0
    t.integer "hbp",        default: 0
    t.integer "single",     default: 0
    t.integer "double",     default: 0
    t.integer "triple",     default: 0
    t.integer "homerun",    default: 0
    t.integer "fb",         default: 0
    t.integer "ld",         default: 0
    t.integer "gb",         default: 0
    t.integer "outs",       default: 0
    t.integer "r",          default: 0
    t.integer "er",         default: 0
    t.integer "sb",         default: 0
    t.integer "k",          default: 0
    t.index ["pitcher_id"], name: "index_pitcher_stats_on_pitcher_id", using: :btree
  end

  create_table "pitchers", force: :cascade do |t|
    t.integer "player_id"
    t.integer "team_id"
    t.string  "owner_type"
    t.integer "owner_id"
    t.boolean "starter",    default: false
    t.index ["owner_type", "owner_id"], name: "index_pitchers_on_owner_type_and_owner_id", using: :btree
    t.index ["player_id"], name: "index_pitchers_on_player_id", using: :btree
    t.index ["team_id"], name: "index_pitchers_on_team_id", using: :btree
  end

  create_table "players", force: :cascade do |t|
    t.string "name",      default: ""
    t.string "identity",  default: ""
    t.string "abbr",      default: ""
    t.string "bathand",   default: ""
    t.string "throwhand", default: ""
  end

  create_table "seasons", force: :cascade do |t|
    t.integer "year"
  end

  create_table "seasons_teams", id: false, force: :cascade do |t|
    t.integer "season_id"
    t.integer "team_id"
    t.index ["season_id"], name: "index_seasons_teams_on_season_id", using: :btree
    t.index ["team_id"], name: "index_seasons_teams_on_team_id", using: :btree
  end

  create_table "teams", force: :cascade do |t|
    t.string  "name"
    t.string  "abbr"
    t.string  "alt_abbr"
    t.integer "fangraph_id"
    t.string  "city"
    t.string  "stadium"
    t.string  "league"
    t.string  "division"
    t.string  "zipcode"
    t.integer "timezone"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
  end

  add_foreign_key "batter_stats", "batters"
  add_foreign_key "batters", "players"
  add_foreign_key "batters", "teams"
  add_foreign_key "game_dates", "seasons"
  add_foreign_key "games", "game_dates"
  add_foreign_key "games", "seasons"
  add_foreign_key "innings", "games"
  add_foreign_key "pitcher_stats", "pitchers"
  add_foreign_key "pitchers", "players"
  add_foreign_key "pitchers", "teams"
end
