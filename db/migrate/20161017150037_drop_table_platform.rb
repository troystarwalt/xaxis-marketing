class DropTablePlatform < ActiveRecord::Migration[5.0]
  def change
    drop_table :platforms
  end
end
