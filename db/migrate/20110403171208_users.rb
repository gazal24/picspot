class Users < ActiveRecord::Migration
  def self.up
    create_table :users do |u|
      u.column :name, :string, :limit => 32, :null => false
      u.column :location, :string, :limit => 32, :null => false
      u.column :sex, :string, :limit => 1, :null => false
    end
  end
  
  def self.down
    drop_table :users
  end
end
