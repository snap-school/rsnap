class AddPolymorphismToCoursesChaptersAndMissions < ActiveRecord::Migration
  def change
  	add_column :courses, :teacher_type, :string
  	add_column :chapters, :teacher_type, :string
  	add_column :missions, :teacher_type, :string
  end
end
