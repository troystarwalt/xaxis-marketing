class AddTitleToPhoto < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :title, :string
  end
end
