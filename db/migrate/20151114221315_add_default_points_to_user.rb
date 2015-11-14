class AddDefaultPointsToUser < ActiveRecord::Migration
  def change
    change_column :users, :current_points, :integer, default: 0
  end
end
