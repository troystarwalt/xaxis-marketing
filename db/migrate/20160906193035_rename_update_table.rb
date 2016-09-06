class RenamepostTable < ActiveRecord::Migration[5.0]
  def change
    rename_table :updates, :posts
  end
end
