class Emailandpass < ActiveRecord::Migration
  def self.up
    add_column :users, :email, :string, :limit => 32, :null => false
    add_column :users, :password, :string, :limit => 32, :null => false
  end
  
  def self.down
    drop_column :users, :email
    drop_column :users, :password
  end
end
