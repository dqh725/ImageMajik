class CreateSharedImages < ActiveRecord::Migration
  def change
    create_table :shared_images do |t|
      t.integer :user_id
      t.integer :image_id

      t.timestamps
    end
  end
end
