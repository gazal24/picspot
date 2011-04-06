class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |c|
      c.column :post, :string, :limit => 32, :null => false
      c.column :picture_id, :integer, :limit => 10, :null => false
      c.column :user_id, :integer, :limit => 10, :null => false
      c.column :created_at, :timestamp, :null => false
    end
  end

  def self.down
    drop_table :comments
  end
end
