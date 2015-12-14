class AddSecondaryToImages < ActiveRecord::Migration
  def change
    add_column :images, :secondary, :boolean, default: false
  end
end
