# frozen_string_literal: true
ActiveAdmin.register BrandAccessory do

  menu parent: "Brands"

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
      f.input :file
    end
    f.actions
  end

  index do
    selectable_column
    id_column
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
      row :id
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
