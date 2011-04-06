class Pictures < ActiveRecord::Migration
  def self.up
    create_table :pictures do |p|
      #here comes the picture
      p.column :pic, :string, :limit => 32, :null => false
      p.column :user_id, :integer, :limit => 10, :null => false
      p.column :directory_id, :integer, :limit => 10, :null => false
      p.column :created_at, :timestamp, :null => false
    end
  end
  
  def self.down
    drop_table :pictures
  end
end
