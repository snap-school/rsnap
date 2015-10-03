class AddTeacherToCoursesChaptersAndMissions < ActiveRecord::Migration
  def change
  	add_column :chapters, :teacher_id, :integer
  	add_column :missions, :teacher_id, :integer
  end
end
