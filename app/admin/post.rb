# frozen_string_literal: true
ActiveAdmin.register Post do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  menu priority: 2, label: proc { I18n.t "post"}

  permit_params :title, :text, :author, :image, :tag_list, :preview_image, :image_cache, :preview_image_cache, :published_at, :remove_preview_image, :remove_image

  filter :title
  filter :tag_list
  filter :text
  filter :updated_at

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
    column :title
    column :text do |f|
      f.medium_teaser
    end
    column :author
    column :tag_list
    column :image do |f|
      image_tag(f.image.url(:thumb)).html_safe
    end
    column :preview_image do |f|
      if f.preview_image.file.nil?
        status_tag 'no', label: "None"
      else
        status_tag 'yes', label: "Yep"
      end
    end
    column :updated_at
    column :published_at do |f|
      if f.published_at.nil?
        status_tag 'no', label: "Nope"
      else
        status_tag 'published', class: 'yes', label: f.published_at.strftime("%m/%d/%y")
      end
    end
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
      row :published_at do |f|
        if f.published_at.nil?
          status_tag 'no', label: "Not Published"
        else
          status_tag 'published', class: 'yes', label: f.published_at.strftime("%B %d, %Y")
        end
      end
      active_admin_comments
    end
  end

  form do |f|
    f.inputs "New Post" do
      f.input :published_at, as: :datepicker,
        datepicker_options: {
          min_date: "2016-01-01",
          max_date: "+2W",
          show_anim: "slideDown"
          }, hint: "Leave blank if you aren't ready to post."
      f.input :title, label: "Title of Post", placeholder: "Ex: Xaxis Holiday Party is at 10 AM on July 8th."
      f.input :text, placeholder: "You can add basic html code here. That includes anchor tags which generate a link.", hint: "Valid tags: <br />, <p>, <strong>, <ul>, <li>. Example: <a href='www.google.com'>Google</a>"
      f.input :author, as: "hidden", :input_html => { value: f.current_admin_user.email }
      panel "Featured Image", class:"nested-input"  do
        if f.object.image?
          panel "Current Main Image" do
            columns do
              column do
                image_tag f.object.image.thumb.url
              end
              column do
                f.check_box :remove_image, as: :boolean, require: false
                text_node "<span class='ml-aa-ten'>Just want to remove the file? Check this and hit update.</span>".html_safe
              end
            end
          end
          file_label = 'Replace Image'
        end
        f.input :image, as: :file, id: "preview_this_image",
        label: file_label || "Add Post Image",
        hint: "Maximum photo size is 5mb.",
        input_html: {
          title: (f.object.image? ?
          "Replace Image" :
          "Upload Image"
          ),
          data: {type: 'png'}
        }
      end
      panel "Background Image", class:"nested-input" do
        if f.object.preview_image?
          panel "Current Background Image" do
            columns do
              column do
                image_tag f.object.preview_image.thumb.url
              end
              column do
                f.check_box :remove_preview_image, as: :boolean, require: false
                text_node "<span class='ml-aa-ten'>Just want to remove the file? Check this and hit update.</span>".html_safe
              end
            end
          end
          preview_file_label = 'Replace Background Image'
        end
        f.input :preview_image, as: :file, id: "preview_this_preview_image",
        label: preview_file_label || "Add Background Image",
        hint: "Maximum photo size is 5mb.",
        input_html: {
          title: (f.object.preview_image? ?
          "Replace Background Image" :
          "Upload Backgroun Image"
          ),
          data: {type: 'png'}
        }
      end
      f.input :preview_image, as: :file, id: "preview_this_preview_image",
      label: "Add Background Image",
      hint: "Maximum photo size is 5mb.",
      input_html: {
        title: (f.object.preview_image? ?
        "Replace Background Image" :
        "Upload Backgroun Image"
        ),
        data: {type: 'png'}
      }
      f.hidden_field :image_cache
      f.hidden_field :preview_image_cache
      f.input :tag_list,
      as: :radio,
      label: "Tag",
      multiple: :false,
      collection: Post.valid_tags
    end
    f.actions
  end
end
