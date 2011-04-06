class CreateFriends < ActiveRecord::Migration
  def self.up
    create_table :friends do |t|
      t.column :user_id1, :integer
      t.column :user_id2, :integer            
      t.column :accepted
    end
  end

  def self.down
    drop_table :friends
  end
end
