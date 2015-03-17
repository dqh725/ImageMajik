class AddInTrashToImages < ActiveRecord::Migration
  def change
    add_column :images, :inTrash, :boolean
  end
end
