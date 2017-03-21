ActiveAdmin.register Photo do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :image, :description, :taken, :image_cache, :tag_list, :title

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

  form do |f|
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
      f.hidden_field :image_cache
      f.input :taken, label: "Taken on:", as: :date_select, hint: "When was the photo taken?"
      f.input :tag_list, hint: "Use all-hands if you want to include this in All Hands", required: true
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
