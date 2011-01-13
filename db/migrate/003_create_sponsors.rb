class CreateSponsors < ActiveRecord::Migration
  def self.up
    create_table :sponsors do |t|
      t.string :username, :null => false, :limit => 30
      t.string :password, :null => false, :limit => 255
      t.string :name, :null => false, :limit => 150
      t.string :company, :limit => 150
      t.string :email, :null => false, :limit => 100
      t.string :phone, :limit => 10
      t.string :cell_phone, :limit => 10
      t.string :address, :null => false, :limit => 200
      t.string :city, :null => false, :limit => 100
      t.date :date, :null => false
      t.boolean :active, :null => false, :default => 1
    end
  end

  def self.down
    drop_table :sponsors
  end
end
