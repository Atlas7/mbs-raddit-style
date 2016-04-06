class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles, :force => true do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :name
      t.date :birthday
      t.string :sex
      t.string :tel
      t.string :address
      t.string :tagline
      t.text :introduction
      t.attachment :avatar
    end
  end
end
