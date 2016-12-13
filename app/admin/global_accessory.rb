# frozen_string_literal: true
ActiveAdmin.register GlobalAccessory do
  # This is where admmins can add global accessories. These do not belong to a specific brand or platform.
  # Base categories include:
  # image_bank
  # generic

  # There is validation that only allows specific file extensions. Check the FileUploader for specifics.
  menu label: "Global", priority: 20

  permit_params :name, :category, :file, :brand_id

  form :html => { :multipart => true } do |f|
    f.semantic_errors *f.object.errors.keys
    para "This is for assets that doesn't belong to just one brand or platform."
    f.inputs "Create a New Global Accessory" do
      f.input :category, as: :radio, :collection => GlobalAccessory::CATEGORIES
      f.input :name, placeholder: "This is for our use."
      f.input :file, input_html: {data: {type: 'bank'}}, hint: "Maximum Size 300mb"
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :name
    column :category
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
        f.file_identifier
      end
      active_admin_comments
    end
  end

end
