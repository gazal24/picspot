class Comments < ActiveRecord::Migration
  def self.up

  end
  
  def self.down
    drop_table :comments
  end
end
