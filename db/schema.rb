# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20140420131844) do

  create_table "glasses", :force => true do |t|
    t.string   "glasses_name",       :null => false
    t.string   "description"
    t.float    "price"
    t.integer  "manufacturer_id",    :null => false
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "glasses", ["manufacturer_id"], :name => "fk_glasses_manufacturers"

  create_table "manufacturers", :force => true do |t|
    t.string   "company_name"
    t.string   "city"
    t.string   "telephone"
    t.string   "mail"
    t.string   "address"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
