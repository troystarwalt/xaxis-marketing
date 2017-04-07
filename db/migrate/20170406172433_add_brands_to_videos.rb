class AddBrandsToVideos < ActiveRecord::Migration[5.0]
  def change
    add_reference :videos, :brand, foreign_key: true
  end
end
