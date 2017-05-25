class DropTableInfographic < ActiveRecord::Migration[5.0]
  def change
    drop_table :infographics
  end
end
