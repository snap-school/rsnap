class RemoveCourseFromStudentAndCreateStudentCourses < ActiveRecord::Migration
  def change
    remove_column :students, :course_id

    create_table :student_courses do |t|
      t.integer :student_id
      t.integer :course_id
    end

    add_index :student_courses, [:student_id, :course_id]
  end
end
