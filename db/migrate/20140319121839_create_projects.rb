class CreateProjects < ActiveRecord::Migration
  def up
    create_table :projects do |t|
      t.string :name
      t.references :user
      t.attachment :source_code
    end
    add_index :projects, :user_id
  end

  def down
    drop_table :projects
  end
end
