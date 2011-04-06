class Todo < ActiveRecord::Migration
  def self.up
    create_table :todos do |t|
      t.column :post, :string, :null => false
      t.column :user, :string, :null => true
    end
  end

  def self.down
    drop_table :todos
  end
end
