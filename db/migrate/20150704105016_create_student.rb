class CreateStudent < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.integer :user_id
    end
    add_index :students, :user_id,                unique:  true
  end
end
