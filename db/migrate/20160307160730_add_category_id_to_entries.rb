class AddCategoryIdToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :category_id, :integer
    add_index :entries, :category_id
  end
end


