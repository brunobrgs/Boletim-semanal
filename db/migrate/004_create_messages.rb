class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.string :title, :null => false, :limit => 30
      t.string :text, :null => false, :limit => 500
      t.string :ident, :null => false, :limit => 1, :default => 'M'
      t.datetime :date, :null => false
      t.references :user
      t.references :sponsor
      t.integer :message_id
      t.datetime :deleted_by_user
      t.datetime :deleted_by_sponsor
      t.boolean :readed, :null => false, :default => 0
    end
    add_foreign_key "messages", "user_id", "users"
    add_foreign_key "messages", "sponsor_id", "sponsors"
  end

  def self.down
    drop_table :messages
  end
end
