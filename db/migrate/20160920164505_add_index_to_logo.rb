class AddIndexToLogo < ActiveRecord::Migration[5.0]
  def change
    add_index :logos, :brand_id
  end

  def change
    drop_table :materials
  end
end