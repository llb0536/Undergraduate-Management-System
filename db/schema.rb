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

ActiveRecord::Schema.define(:version => 20110427051721) do

  create_table "assignments", :force => true do |t|
    t.integer  "course_id"
    t.integer  "student_id"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.string   "number"
    t.integer  "credit"
    t.boolean  "in_plan"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "number_prefix"
    t.integer  "assignments_count"
  end

  create_table "family_names", :force => true do |t|
    t.string   "hanzi"
    t.string   "letter"
    t.boolean  "exists"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grades", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "import2_logs", :force => true do |t|
    t.integer  "user_id"
    t.integer  "students_updated"
    t.integer  "students_created"
    t.boolean  "erroneous"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "import3_logs", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "import4_logs", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "import_logs", :force => true do |t|
    t.integer  "user_id"
    t.string   "filename"
    t.string   "grade_created"
    t.string   "klass_created"
    t.integer  "course_created_count"
    t.integer  "stu_created_count"
    t.integer  "co_count"
    t.integer  "co_no_count"
    t.boolean  "erroneous"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "klasses", :force => true do |t|
    t.string   "name"
    t.integer  "grade_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.integer  "user_id"
    t.integer  "from_user_id"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "has_read"
  end

  create_table "programs", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "researches", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", :force => true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "number"
    t.string   "bj"
    t.string   "sfh"
    t.string   "mz"
    t.string   "jg"
    t.string   "sbzzmm"
    t.string   "zy"
    t.string   "ksh"
    t.string   "zym"
    t.string   "kq"
    t.string   "wyyz"
    t.string   "lxrxm"
    t.string   "lxrdz"
    t.string   "lxryb"
    t.string   "lxrdh"
    t.string   "kslb"
    t.string   "byzx"
    t.string   "byzxyb"
    t.string   "brtc"
    t.string   "jlcc"
    t.string   "kstz"
    t.string   "tjjljs"
    t.string   "tjsxbzm"
    t.string   "yhkszss"
    t.string   "paixuzi"
    t.text     "ksjl"
    t.boolean  "is_male"
    t.integer  "klass_id"
    t.integer  "fenshuxian"
    t.integer  "rxzf"
    t.integer  "gkzf"
    t.integer  "fjf"
    t.integer  "yw"
    t.integer  "sx"
    t.integer  "wy"
    t.integer  "wl"
    t.integer  "hx"
    t.integer  "zz"
    t.integer  "ls"
    t.integer  "zh"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "number_prefix"
    t.integer  "assignments_count"
    t.string   "xsm"
    t.string   "pyfs"
    t.string   "nd"
    t.string   "tzsh"
    t.string   "csrq"
    t.string   "rxny"
    t.string   "bkzy1"
    t.string   "bkzy2"
    t.string   "bkzy3"
    t.string   "bkzy4"
    t.string   "bkzy5"
    t.string   "bkzy6"
    t.string   "zyh"
    t.string   "xsh"
    t.string   "sfl"
    t.string   "wlfl"
    t.string   "lqlb"
    t.integer  "zhuanye_id"
  end

  create_table "tables", :force => true do |t|
    t.text     "checked_grades"
    t.text     "checked_klasses"
    t.text     "checked_students"
    t.text     "checked_courses"
    t.text     "checked_courses_quan"
    t.text     "result"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "reason"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.boolean  "is_admin"
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["name"], :name => "index_users_on_name", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "warnings", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "zhuanyes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
