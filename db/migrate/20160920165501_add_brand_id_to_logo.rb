class AddBrandIdToLogo < ActiveRecord::Migration[5.0]
  def change
    add_reference :logos, :brand, index: true
    add_foreign_key :logos, :brands
  end
end
