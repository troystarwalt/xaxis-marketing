class AddSlugToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :slug, :string
    Post.find_each(&:save)
  end
end
