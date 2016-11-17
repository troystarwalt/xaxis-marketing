# frozen_string_literal: true
class AddDableCaseStudy < ActiveRecord::Migration[5.0]
  def change
    create_table :case_studies do |t|
      t.references :platform, foreign_key: true
      t.string :author
      t.datetime :release_date
      t.text :short_description
      t.string :pdf_attachment
      t.string :title
      t.timestamps
    end
  end
end
