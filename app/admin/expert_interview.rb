# frozen_string_literal: true
ActiveAdmin.register ExpertInterview do
  menu label:  "Interview Hub"
  permit_params :vimeo_url, :contributor_name, :contributor_title, :title, :description, :image

  form :html => { :multipart => true } do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Create an Expert Interview" do
      f.input :vimeo_url, hint: "The link should look like this: 'https://player.vimeo.com/video/175274585' Note the 'player' part of the url.", placeholder: "Ex: https://player.vimeo.com/video/175274585"
      f.input :contributor_name, placeholder: "John Smith"
      f.input :contributor_title, placeholder: "CFO"
      f.input :title, placeholder: "Light feafReaction "
      f.input :description
      if f.object.image?
        panel :current_image, label: "Current Image" do
          image_tag f.object.image.url
        end
        file_label = 'Replace Preview Image'
      end
      f.input :image, as: :file, id: "preview_shit",
                                label: file_label || "Upload Preview Image",
                                hint: "Max size is 5mb",
                                input_html: {
                                  title: (f.object.image? ?
                                          "Replace File" :
                                          "Upload File"
                                          ),
                                  data: {type: 'png'}
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
