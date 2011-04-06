class CreateAlbums < ActiveRecord::Migration
  def self.up
    create_table :albums do |a|
      a.column :name, :string, :limit => 32, :null => false
      a.column :user_id, :integer, :limit => 32, :null => false
      a.column :created_at, :timestamp
    end
  end
  
  def self.down
    drop_table :albums
  end
end
