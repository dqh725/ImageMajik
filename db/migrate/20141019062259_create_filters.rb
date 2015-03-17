class CreateFilters < ActiveRecord::Migration
  def change
    create_table :filters do |t|
      t.integer :blur_value
      t.integer :brightness
      t.integer :hue

      t.timestamps
    end
  end
end
