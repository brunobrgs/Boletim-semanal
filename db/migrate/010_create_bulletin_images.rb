class CreateBulletinImages < ActiveRecord::Migration
  def self.up
    create_table :bulletin_images do |t|
      t.string :image_file_name, :null => false, :limit => 50
      t.references :bulletin_part, :null => false
    end
    add_foreign_key "bulletin_images", "bulletin_part_id", "bulletin_parts"
  end

  def self.down
    drop_table :bulletin_images
  end
end
