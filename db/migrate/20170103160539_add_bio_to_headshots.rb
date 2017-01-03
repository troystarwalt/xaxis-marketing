class AddBioToHeadshots < ActiveRecord::Migration[5.0]
  def change
    add_column :headshots, :bio, :text
  end
end
