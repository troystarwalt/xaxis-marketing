class CreateCaseStudies < ActiveRecord::Migration[5.0]
  # Had to comment this out and then create a new migration to drop the prevous case study table.
  # def change
  #   create_table :case_studies do |t|
  #     t.references :platform, foreign_key: true
  #     t.string :author
  #     t.datetime :release_date
  #     t.text :short_description
  #     t.string :pdf_attachment
  #     t.string :title
  #     t.timestamps
  #   end
  # end
end
