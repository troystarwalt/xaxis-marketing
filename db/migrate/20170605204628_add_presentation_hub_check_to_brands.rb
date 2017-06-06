class AddPresentationHubCheckToBrands < ActiveRecord::Migration[5.0]
  def change
    add_column :brands, :presentation_hub, :boolean, default: false
  end
end
