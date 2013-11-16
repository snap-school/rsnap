class CreateFileMissions < ActiveRecord::Migration
  def change
    create_table :file_missions do |t|
      t.references :mission, index: true
      t.attachment :file

      t.timestamps
    end
  end
end
