class DropTableLogos < ActiveRecord::Migration[5.0]
  def change
    drop_table :logos
  end
end
