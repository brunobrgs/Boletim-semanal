# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 10) do

  create_table "bulletin_images", :force => true do |t|
    t.string  "image",            :limit => 50, :null => false
    t.integer "bulletin_part_id",               :null => false
  end

  add_index "bulletin_images", ["bulletin_part_id"], :name => "bulletin_images_bulletin_parts_fkey"

  create_table "bulletin_parts", :force => true do |t|
    t.string  "title",           :limit => 70, :null => false
    t.text    "text",                          :null => false
    t.integer "bulletin_id",                   :null => false
    t.integer "interface_id",                  :null => false
    t.string  "image1",          :limit => 50
    t.string  "image2",          :limit => 50
    t.string  "image3",          :limit => 50
    t.integer "sequence_number",               :null => false
  end

  add_index "bulletin_parts", ["bulletin_id"], :name => "bulletin_parts_bulletins_fkey"
  add_index "bulletin_parts", ["interface_id"], :name => "bulletin_parts_interfaces_fkey"

  create_table "bulletin_texts", :force => true do |t|
    t.text    "text",             :null => false
    t.integer "bulletin_part_id", :null => false
  end

  add_index "bulletin_texts", ["bulletin_part_id"], :name => "bulletin_texts_bulletin_parts_fkey"

  create_table "bulletins", :force => true do |t|
    t.string  "title",   :limit => 70, :null => false
    t.integer "user_id",               :null => false
    t.date    "date",                  :null => false
  end

  add_index "bulletins", ["user_id"], :name => "bulletins_users_fkey"

  create_table "components", :force => true do |t|
    t.integer "interface_id",                                  :null => false
    t.string  "ident",        :limit => 30,                    :null => false
    t.string  "width",        :limit => 5,                     :null => false
    t.string  "height",       :limit => 5,                     :null => false
    t.string  "top",          :limit => 5
    t.string  "right",        :limit => 5
    t.string  "bottom",       :limit => 5
    t.string  "left",         :limit => 5
    t.boolean "image",                      :default => false, :null => false
  end

  create_table "emails", :force => true do |t|
    t.string "email", :limit => 100, :null => false
    t.date   "date",                 :null => false
  end

  create_table "interfaces", :force => true do |t|
    t.string "name",  :limit => 100, :null => false
    t.string "width", :limit => 5,   :null => false
  end

  create_table "messages", :force => true do |t|
    t.string   "title",              :limit => 30,                     :null => false
    t.string   "text",               :limit => 500,                    :null => false
    t.string   "ident",              :limit => 1,   :default => "M",   :null => false
    t.datetime "date",                                                 :null => false
    t.integer  "user_id"
    t.integer  "sponsor_id"
    t.integer  "message_id"
    t.datetime "deleted_by_user"
    t.datetime "deleted_by_sponsor"
    t.boolean  "readed",                            :default => false, :null => false
  end

  add_index "messages", ["sponsor_id"], :name => "messages_sponsors_fkey"
  add_index "messages", ["user_id"], :name => "messages_users_fkey"

  create_table "sponsors", :force => true do |t|
    t.string  "username",   :limit => 30,                    :null => false
    t.string  "password",                                    :null => false
    t.string  "name",       :limit => 150,                   :null => false
    t.string  "company",    :limit => 150
    t.string  "email",      :limit => 100,                   :null => false
    t.string  "phone",      :limit => 10
    t.string  "cell_phone", :limit => 10
    t.string  "address",    :limit => 200,                   :null => false
    t.string  "city",       :limit => 100,                   :null => false
    t.date    "date",                                        :null => false
    t.boolean "active",                    :default => true, :null => false
  end

  create_table "users", :force => true do |t|
    t.string  "username", :limit => 30,                     :null => false
    t.string  "password",                                   :null => false
    t.string  "name",     :limit => 100,                    :null => false
    t.date    "date",                                       :null => false
    t.boolean "active",                  :default => true,  :null => false
    t.boolean "delta",                   :default => false, :null => false
  end

end
