class CreateUpdates < ActiveRecord::Migration[5.0]
  def change
    create_table :updatess do |t|
      t.string :title, :null => false
      t.text :text, :null => false
      t.string :author

      t.timestamps
    end
  end
end
