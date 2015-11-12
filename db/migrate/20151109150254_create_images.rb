class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :product
      t.string :path

      t.timestamps null: false
    end
  end
end
