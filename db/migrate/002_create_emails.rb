class CreateEmails < ActiveRecord::Migration
  def self.up
    create_table :emails do |t|
      t.string :email, :null => false, :limit => 100
      t.date :date, :null => false
    end
  end

  def self.down
    drop_table :emails
  end
end
