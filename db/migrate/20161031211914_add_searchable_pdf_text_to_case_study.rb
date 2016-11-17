# frozen_string_literal: true
class AddSearchablePdfTextToCaseStudy < ActiveRecord::Migration[5.0]
  def change
    add_column :case_studies, :searchable_pdf_text, :text
  end
end
