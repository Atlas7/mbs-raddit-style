class CreateEntryElements < ActiveRecord::Migration
  def change
    create_table :entry_elements do |t|
      t.references :entry
      t.references :element, polymorphic: true, index: true
      t.timestamps null: false
    end
  end
end
