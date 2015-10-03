class CreateTeacher < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.integer :user_id
    end
  end
end
