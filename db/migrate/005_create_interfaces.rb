class CreateInterfaces < ActiveRecord::Migration
  def self.up
    create_table :interfaces do |t|
      t.string :name, :null => false, :limit => 100
      t.string :width, :null => false, :limit => 5
    end
  end

  def self.down
    drop_table :interfaces
  end
end
