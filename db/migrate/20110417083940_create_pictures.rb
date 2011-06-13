class CreatePictures < ActiveRecord::Migration
  def self.up
    create_table :pictures do |t|
      t.integer :album_id
      t.integer :user_id
      t.column :caption, :string, :limit => 200, :null => true

      t.timestamps
    end
  end

  def self.down
    drop_table :pictures
  end
end
