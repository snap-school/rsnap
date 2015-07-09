class AddCourseToStudent < ActiveRecord::Migration
  def change
  	add_column :students, :course_id, :integer
  end
end
