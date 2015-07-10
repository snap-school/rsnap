class RemoveChapterOrder < ActiveRecord::Migration
  def change
  	remove_column :chapters, :chapter_order
  end
end
