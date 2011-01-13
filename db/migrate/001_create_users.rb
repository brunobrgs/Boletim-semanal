class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username, :null => false, :limit => 30
      t.string :password, :null => false, :limit => 255
      t.string :name, :null => false, :limit => 100
      t.date :date, :null => false
      t.active :boolean, :null => false, :default => 1
      t.delta :boolean, :null => false, :default => 0
    end
  end

  def self.down
    drop_table :users
  end
end
