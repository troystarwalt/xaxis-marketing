# frozen_string_literal: true
ActiveAdmin.register Infographic do
  menu parent: "Platforms"
  permit_params :name, :description, :image_preview, :file, :platform_id

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form :html => { :multipart => true } do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Create a New Inforgraphic Accessory" do
      f.input :platform, as: :radio
      f.input :name, placeholder: "Name of Infographic"
      f.input :description
      f.input :image_preview, as: :file
      f.input :file, as: :file
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :name
    column :image_preview do |f|
      if !f.image_preview.present?
        image_tag(f.image_preview_url, class: "admin_show_image")
      elsif f.image_preview.content_type.start_with? 'image'
        image_tag(f.image_preview.thumb, class: "admin_show_image")
      else
        f.image_preview_url
      end
    end
    column :platform_id do |f|
      f.platform.name
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :preview do |f|
        if !f.image_preview.present?
          image_tag(f.image_preview_url, class: "admin_show_image")
        elsif f.image_preview.content_type.start_with? 'image'
          image_tag(f.image_preview.preview, class: "admin_show_image")
        else
          f.image_preview_url
        end
      end
      row :file do |f|
        f.file_identifier
      end
      row :platform
      row :created_at
      row :updated_at
    end
  end

  controller do
    def scoped_collection
      super.includes :platform # prevents N+1 queries to your database
    end
  end

end
