class AddFilterNameToFilter < ActiveRecord::Migration
  def change
    add_column :filters, :FilterName, :string
  end
end
