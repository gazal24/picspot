class Directories < ActiveRecord::Migration
  def self.up
    create_table :directories do |d|
      d.column :name, :string, :limit => 32, :null => false
      d.column :user_id, :integer, :limit => 32, :null => false
      d.column :created_at, :timestamp
    end
  end
  
  def self.down
    drop_table :directories
  end
end
