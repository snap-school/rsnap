class AddOrderToChapter < ActiveRecord::Migration
  def change
    add_column :chapters, :chapter_order, :integer, default:  0
  end
end
