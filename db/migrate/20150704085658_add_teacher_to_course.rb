class AddTeacherToCourse < ActiveRecord::Migration
  def change
  	add_column :courses, :teacher_id, :integer
  end
end
