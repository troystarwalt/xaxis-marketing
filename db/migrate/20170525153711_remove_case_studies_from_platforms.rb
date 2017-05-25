class RemoveCaseStudiesFromPlatforms < ActiveRecord::Migration[5.0]
  def change
    remove_column :case_studies, :platform_id
  end
end
