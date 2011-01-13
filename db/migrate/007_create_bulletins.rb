class CreateBulletins < ActiveRecord::Migration
  def self.up
    create_table :bulletins do |t|
      t.string :title, :null => false, :limit => 70
      t.references :user, :null => false
      t.date :date, :null => false
    end
    add_foreign_key "bulletins", "user_id", "users"
  end

  def self.down
    drop_table :bulletins
  end
end
