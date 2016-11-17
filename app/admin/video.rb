# frozen_string_literal: true
ActiveAdmin.register Video do
  menu parent: "Platforms"
  permit_params :name, :description, :direct_link, :embed_link, :image_preview, :platform_id

  # before_save do |video|
  #   get_link = VideoThumb::get(video.direct_link)
  #   video.image_preview = open(get_link)
  #   byebug
  # end

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :direct_link do |f|
      link_to f.direct_link, f.direct_link, target: "_blank"
    end
    column :embed_link
    column :image_preview do |f|
      if f.image_preview.present?
        image_tag(f.image_preview, class: 'admin_show_image')
      end
    end
    column :created_at
    column :updated_at
    actions
  end

  form :html => { :multipart => true } do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Create a New video" do
      f.input :platform, as: :radio
      f.input :name, placeholder: "Video Name"
      f.input :description
      f.input :direct_link
      f.input :embed_link
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :direct_link
      row :embed_link
      row :image_preview do |f|
        if f.image_preview.present?
          image_tag(f.image_preview, class: 'admin_show_image')
        end
      end
      row :platform
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

end
