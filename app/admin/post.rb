# frozen_string_literal: true
ActiveAdmin.register Post do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  menu priority: 2, label: proc { I18n.t "post"}

  permit_params :title, :text, :author, :image, :tag_list, :preview_image

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end

    def scoped_collection
      super.includes :taggings # prevents N+1 queries to your database
    end

  end

    index do
      selectable_column
      id_column
      column :title
      column :text do |f|
        f.medium_teaser
      end
      column :author
      column :tag_list
      column :image do |f|
        image_tag(f.image.url(:thumb)).html_safe
      end
      column :updated_at
      actions
    end

  show do
    attributes_table do
      row :title
      row :text
      row :author
      row :image do |f|
        image_tag(f.image.url(:thumb)).html_safe
      end
      row :preview do |f|
        image_tag(f.preview_image.url(:thumb)).html_safe
      end
      row :created_at
      row :updated_at
      active_admin_comments
    end
  end

  filter :title
  filter :tag_list
  filter :text
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs "New Post" do
      f.input :title, label: "Title of Post", placeholder: "Ex: Xaxis Holiday Party is at 10 AM on July 8th."
      f.input :text, placeholder: "You can add basic html code here. That includes anchor tags which generate a link.", hint: "Valid tags: <br />, <p>, <strong>, <ul>, <li>. Example: <a href='www.google.com'>Google</a>"
      f.input :author, as: "hidden", :input_html => { value: f.current_admin_user.email }
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
      if f.object.preview_image?
        panel "Current Background" do
          image_tag f.object.preview_image.thumb.url
        end
        file_label = 'Replace Background Image'
      end
      f.input :preview_image, as: :file, id: "preview_this_image",
                                label: file_label || "Upload Background Image",
                                hint: "Maximum photo size is 5mb.",
                                input_html: {
                                  title: (f.object.preview_image? ?
                                          "Replace Background Image" :
                                          "Upload Backgroun Image"
                                          ),
                                  data: {type: 'png'}
                                }
      f.hidden_field :image_cache
      # f.input :image, as: :file, label: "Image", input_html: {data: {type: 'png'}}, hint: "Maximum 5mb"
      # f.input :preview_image, as: :file, label: "Preview Image", input_html: {data: {type: 'png'}}, hint: "This is for the homepage squre. Maximum 5mb."
      f.input :tag_list,
        as: :radio,
        label: "Tag",
        multiple: :false,
        hint: "Choose 1",
        collection: Post.valid_tags
    end
    f.actions
  end
end
