class OrderingMissions < ActiveRecord::Migration
  def change
    add_column :missions, :small_description, :string, :default=>""
  end
end
