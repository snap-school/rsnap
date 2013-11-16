class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.attachment :source_code

      t.timestamps
    end
  end
end
