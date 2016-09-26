class AddFileToLogos < ActiveRecord::Migration[5.0]
  def change
    add_column :logos, :file, :string
  end
end
