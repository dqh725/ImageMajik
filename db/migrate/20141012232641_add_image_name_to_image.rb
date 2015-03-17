class AddImageNameToImage < ActiveRecord::Migration
  def change
    add_column :images, :imageName, :string
  end
end
