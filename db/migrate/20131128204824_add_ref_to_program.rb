class AddRefToProgram < ActiveRecord::Migration
  def change
    add_reference :programs, :user, index: true
    add_reference :programs, :mission, index: true
  end
end
