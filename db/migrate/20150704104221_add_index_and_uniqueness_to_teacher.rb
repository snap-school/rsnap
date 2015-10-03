class AddIndexAndUniquenessToTeacher < ActiveRecord::Migration
  def change
  	 add_index :teachers, :user_id,                unique:  true
  end
end
