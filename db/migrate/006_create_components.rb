class CreateComponents < ActiveRecord::Migration
  def self.up
    create_table :components do |t|
      t.references :interface, :null => false
      t.string :ident, :null => false, :limit => 30
      t.string :width, :null => false, :limit => 5
      t.string :height, :null => false, :limit => 5
      t.string :top, :limit => 5
      t.string :right, :limit => 5
      t.string :bottom, :limit => 5
      t.string :left, :limit => 5
      t.boolean :image, :null => false, :default => 0
    end
    add_foreign_key "components", "interface_id", "interfaces"
  end

  def self.down
    drop_table :components
  end
end
