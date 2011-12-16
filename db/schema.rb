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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111207041034) do

  create_table "frequent_per_min_terms", :force => true do |t|
    t.integer  "frequency"
    t.integer  "term_id"
    t.integer  "per_min_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "frequent_per_min_terms", ["per_min_id"], :name => "index_frequent_per_min_terms_on_per_min_id"
  add_index "frequent_per_min_terms", ["term_id"], :name => "index_frequent_per_min_terms_on_term_id"

  create_table "per_five_mins", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "per_min_stream_term_totals", :force => true do |t|
    t.integer  "total"
    t.integer  "per_min_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "per_min_stream_term_totals", ["per_min_id"], :name => "index_per_min_stream_term_totals_on_per_min_id"

  create_table "per_min_stream_tweet_totals", :force => true do |t|
    t.integer  "total"
    t.integer  "per_min_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "per_min_stream_tweet_totals", ["per_min_id"], :name => "index_per_min_stream_tweet_totals_on_per_min_id"

  create_table "per_mins", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "terms", :force => true do |t|
    t.string   "term"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tt_terms", :force => true do |t|
    t.string   "term"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tts", :force => true do |t|
    t.integer  "position"
    t.integer  "tt_term_id"
    t.integer  "per_5_min_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tts", ["per_5_min_id"], :name => "index_tts_on_per_5_min_id"
  add_index "tts", ["tt_term_id"], :name => "index_tts_on_tt_term_id"

  create_table "zscore_currents", :force => true do |t|
    t.float    "zscore"
    t.integer  "term_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "zscore_currents", ["term_id"], :name => "index_zscore_currents_on_term_id"

  create_table "zscore_historicals", :force => true do |t|
    t.integer  "n"
    t.integer  "sum"
    t.float    "sqr_total"
    t.integer  "first_min"
    t.integer  "last_min"
    t.integer  "term_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "zscore_historicals", ["term_id"], :name => "index_zscore_historicals_on_term_id"

  create_table "zscores", :force => true do |t|
    t.float    "zscore"
    t.integer  "per_min_id"
    t.integer  "term_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "zscores", ["per_min_id"], :name => "index_zscores_on_per_min_id"
  add_index "zscores", ["term_id"], :name => "index_zscores_on_term_id"

end
