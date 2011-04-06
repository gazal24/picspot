class AddBirthday < ActiveRecord::Migration
  def self.up
    add_column :users, :birthday, :date
  end
  
  def self.down
    drop_column :users, :birthday
  end
end
