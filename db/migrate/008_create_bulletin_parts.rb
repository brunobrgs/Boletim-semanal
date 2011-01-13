class CreateBulletinParts < ActiveRecord::Migration
  def self.up
    create_table :bulletin_parts do |t|
      t.string :title, :null => false, :limit => 70
      t.references :bulletin, :null => false
      t.references :interface, :null => false
      t.integer :sequence_number, :null => false
    end
    add_foreign_key "bulletin_parts", "bulletin_id", "bulletins"
    add_foreign_key "bulletin_parts", "interface_id", "interfaces"
  end

  def self.down
    drop_table :bulletin_parts
  end
end
