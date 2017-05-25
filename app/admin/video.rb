# frozen_string_literal: true
ActiveAdmin.register Video do
  menu parent: "Global Accessories"
  permit_params :name, :description, :direct_link, :embed_link, :image_preview, :brand_id, :box_download_link

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
    column :box_download_link
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
      f.input :brand, as: :radio
      f.input :name, placeholder: "Video Name"
      f.input :description, hint: "Not required, but it can be useful for you."
      f.input :direct_link, placeholder: "https://vimeo.com/149429953", hint: "Use the basic vimeo link."
      f.input :box_download_link, placeholder: "https://xaxismarketing.box.com/s/dyonll3dqavgofubvm04lp77cz0zk4sr", hint: "Make sure to put the correct sharing link for others here."
      f.input :image_preview, as: :file, hint: "Upload image here. If you don't have one, we'll try and grab an image from Vimeo."
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :direct_link
      row :embed_link
      row :box_download_link
      row :vimeo_video_id
      row :image_preview do |f|
        if f.image_preview.present?
          image_tag(f.image_preview, class: 'admin_show_image')
        end
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

end
