# frozen_string_literal: true
ActiveAdmin.register BrandAccessory do

  menu parent: "Brands"

  filter :brand
  filter :category, as: :select
  filter :name

  # This is where admmins can add the accessories for each brand. This includes:
  # ppt_template
  # word_template
  # guidlines
  # capabilities
  # logos
  # fonts
  # color palettes
  # fast facts

  # There is validation that only allows specific file extensions. Check the FileUploader for specifics.

  permit_params :name, :category, :file, :brand_id

  form :html => { :multipart => true } do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Create a New Brand Accessory" do
      f.input :brand, as: :radio
      f.input :category, as: :radio, :collection => BrandAccessory::CATEGORIES
      f.input :name, label: "Name The File"
      f.input :file, input_html: {data: {type: 'ppt'}}, hint: "Max size is 100mb."
    end
    para "Max upload, as noted is 100mb, but that's mainly for PPT's. Don't get greedy!"
    f.actions
  end

  index do
    para "Note - as of 12/15/16, Fonts aren't going to be available to download."
    selectable_column
    column :name
    column :category
    column :brand_id do |f|
      f.brand.name
    end
    column :created_at
    column :updated_at
    column :file do |f|
      f.file_identifier
    end
    actions
  end

  show do
    attributes_table do
      row :brand do |f|
        f.brand.name
      end
      row :name
      row :category
      row :created_at
      row :updated_at
      row :file do |f|
        link_to f.file_identifier, f.file_url, target: "_blank"
      end
      active_admin_comments
    end
  end

  controller do
    def scoped_collection
      super.includes :brand # prevents N+1 queries to your database
    end
  end
end
