class Pictures < ActiveRecord::Migration
  def self.up
  end
  
  def self.down
    drop_table :pictures
  end
end
