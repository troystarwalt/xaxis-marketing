class RenameAssetsTable < ActiveRecord::Migration[5.0]
  def change
    rename_table :assets, :materials
  end
end
