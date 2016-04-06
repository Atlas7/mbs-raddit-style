class AddMediumIdToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :medium_id, :integer
    add_index :entries, :medium_id
  end
end
