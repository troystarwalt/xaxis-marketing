# frozen_string_literal: true
ActiveAdmin.register ExpertInterview do
  menu label:  "Interview Hub"
  permit_params :name, :category, :file, :brand_id

  form :html => { :multipart => true } do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Create a New Brand Accessory" do
      f.input :vimeo_url
      f.input :contributor_name
      f.input :contributor_title
      f.input :title
      f.input :description
      if f.object.image?
        panel :current_image do
          image_tag f.object.image.url
        end
        file_label = 'Replace PDF Attachment'
      end
      f.input :image, as: :file,
                                label: file_label || "Upload PDF Attachment",
                                input_html: {
                                  title: (f.object.image? ?
                                          "Replace File" :
                                          "Upload File"
                                          )
                                }
    end
    f.actions
  end

  index do
    id_column
    column :contributor_name
    column :title
    column :contributor_title
    column :vimeo_url do |f|
      link_to f.vimeo_url, f.vimeo_url, target: "_blank"
    end
    column :created_at
    column :updated_at
  end

  show do
    attributes_table do
      row :id
      row :contributor_name
      row :title
      row :contributor_title
      row :vimeo_url do |f|
        link_to f.vimeo_url, f.vimeo_url, target: "_blank"
      end
      row :image do |f|
        image_tag f.image.url
      end
      row :created_at
      row :updated_at
    end

  end


end
