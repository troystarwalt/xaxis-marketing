class AddNavToBrands < ActiveRecord::Migration[5.0]
  def change
    add_column :brands, :main_nav, :boolean, default: false
  end
end
