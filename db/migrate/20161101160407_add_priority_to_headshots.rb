class AddPriorityToHeadshots < ActiveRecord::Migration[5.0]
  def change
    add_column :headshots, :priority, :integer
  end
end
