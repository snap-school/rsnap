class FromUserToAbstractUser < ActiveRecord::Migration
  def change
    drop_table :students
    drop_table :teachers
    add_column :users, :type, :string
  end
end
