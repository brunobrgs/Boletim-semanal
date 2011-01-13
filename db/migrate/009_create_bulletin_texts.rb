class CreateBulletinTexts < ActiveRecord::Migration
  def self.up
    create_table :bulletin_texts do |t|
      t.text :text, :null => false, :limit => 1000
      t.references :bulletin_part, :null => false
    end
    add_foreign_key "bulletin_texts", "bulletin_part_id", "bulletin_parts"
  end

  def self.down
    drop_table :bulletin_texts
  end
end
