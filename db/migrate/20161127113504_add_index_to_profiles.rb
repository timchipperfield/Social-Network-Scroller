class AddIndexToProfiles < ActiveRecord::Migration[5.0]
  def change
   add_index :profiles, :updated_at
  end
end
