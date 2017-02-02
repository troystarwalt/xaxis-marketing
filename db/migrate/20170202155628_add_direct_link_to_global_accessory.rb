class AddDirectLinkToGlobalAccessory < ActiveRecord::Migration[5.0]
  def change
    add_column :global_accessories, :remote_download, :string
  end
end
