class RemoveParentIdFromImages < ActiveRecord::Migration
  def change
    remove_column :images, :parent_id, :integer
  end
end
