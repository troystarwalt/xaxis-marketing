ActiveAdmin.register Photo do
  menu parent: "Global Accessories"

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#

  config.create_another = true

  permit_params :image, :description, :taken, :image_cache, :tag_list, :title, :remote_image_url

  action_item :new, only: [:show] do
    link_to 'New', new_admin_photo_path
  end

  controller  do
    def scoped_collection
      super.includes :taggings # prevents N+1 queries to your database
    end
  end

  filter :taken
  filter :tag_list
  filter :title

  # ----------Edit and New Form

  form html: { multipart: true } do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "New Image" do
      f.input :title, placeholder: "Drinking Coffee", hint: "Reference title for photo.", required: true
      f.input :description, placeholder: "A group of people drinking coffee at our event.", hint: "What is this photo about?"
      if f.object.image?
        panel "Current Image" do
          image_tag f.object.image.thumb.url
        end
        file_label = 'Replace Image'
      end
      f.input :image, as: :file, id: "preview_this_image",
                                label: file_label || "Upload Image",
                                hint: "Maximum photo size is 5mb.",
                                input_html: {
                                  title: (f.object.image? ?
                                          "Replace Image" :
                                          "Upload Image"
                                          ),
                                  data: {type: 'png'}
                                }
      para "or", class: "seperator"
      f.input :remote_image_url, as: :string, placeholder: "Ex.: https://github-jobs.s3.amazonaws.com/48997d7a-043e-11e7-89f6-aa4c41cf1794.png", hint: "Don't have the photo on your computer? User a URL."
      f.hidden_field :image_cache
      f.input :taken, label: "Taken on:", as: :date_select, hint: "When was the photo taken?"
      f.input :tag_list, hint: "Comma separated tags. use all-hands, 2017-q2 to be inluded for now.", placeholder: "Ex.: all-hands, 2017-q2", required: true
    end
    f.actions
  end

  # ----------Index View


  index as: :grid do |photo|
    div do
      link_to image_tag(photo.image.thumb), admin_photo_path(photo)
    end
    span photo.tag_list.to_s, :href => admin_photo_path(photo)
  end

  # ----------Show View

  show do
    attributes_table do
      row :title
      row :description
      row :taken
      row :created_at
      row :updated_at
      row :image do |f|
        image_tag(f.image.url(:thumb)).html_safe
      end
      active_admin_comments
    end
  end

end
