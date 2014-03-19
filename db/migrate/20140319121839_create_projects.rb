class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.references :user
      t.attachment :source_code
    end
  end
end
