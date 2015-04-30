class AddStateToPrograms < ActiveRecord::Migration
  def change
  	add_column :programs, :state, :integer, :default=>0
  end
end
