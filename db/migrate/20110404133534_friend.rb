class Friend < ActiveRecord::Migration
  def self.up
    create_table :friends do |t|
      t.column :user1, :integer, :null => false
      t.column :user2, :integer, :null => false            
      t.column :accepted, :boolean, :null => false
    end
  end
  
  def self.down
    drop_table :friends
  end
end
