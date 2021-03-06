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

ActiveRecord::Schema.define(:version => 20130630030421) do

  create_table "documents", :force => true do |t|
    t.integer  "fileshare_id"
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
    t.boolean  "downloaded",            :default => false
    t.boolean  "expired",               :default => false
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  add_index "documents", ["fileshare_id"], :name => "index_documents_on_fileshare_id"

  create_table "fileshares", :force => true do |t|
    t.string   "sender_name"
    t.string   "sender_email"
    t.string   "recipient_email"
    t.text     "message"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "uuid"
  end

end
