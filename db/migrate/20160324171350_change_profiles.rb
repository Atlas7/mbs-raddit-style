class ChangeProfiles < ActiveRecord::Migration
  def change
    remove_foreign_key :profiles, :user
  end
end