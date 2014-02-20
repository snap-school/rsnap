class OrderingMissions < ActiveRecord::Migration
  def change
    add_column :missions, :mission_order, :integer, :default=>0
  end
end
