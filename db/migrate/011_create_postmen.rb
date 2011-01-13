class CreatePostmen < ActiveRecord::Migration
  def self.up
    create_table :postmen do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :postmen
  end
end
