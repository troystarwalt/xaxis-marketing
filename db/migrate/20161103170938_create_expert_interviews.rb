# frozen_string_literal: true
class CreateExpertInterviews < ActiveRecord::Migration[5.0]
  def change
    create_table :expert_interviews do |t|
      t.string :vimeo_url
      t.string :image
      t.string :contributor_name
      t.string :contributor_title
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
