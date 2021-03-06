# frozen_string_literal: true
ActiveAdmin.register Headshot do
  menu parent: "Brands"

  permit_params :first_name, :last_name, :title, :brand_id, :grey_image, :color_image, :priority, :bio, :grey_image_cache, :color_image_cache, :remove_grey_image, :remove_color_image

  # Adds a custom New action on the show page.
  action_item :new, only: [:show] do
    link_to 'New', new_admin_headshot_path
  end

  filter :brand
  filter :last_name
  filter :first_name
  filter :priority

  #
  form :html => { :multipart => true } do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "New Headshot" do
      f.input :first_name, placeholder: "John"
      f.input :last_name, placeholder: "Smith"
      f.input :title, placeholder: "CFO"
      f.input :brand_id, as: :radio, :collection => Hash[Brand.all.map{|b| [b.name, b.id]}], required: true
      f.input :priority, as: :select, :collection => Array(1..20), hint: "A person with Priority of 1 will be listed 1st"
      if f.object.grey_image?
        panel "Current B&W Headshot" do
          columns do
            column do
              image_tag(f.object.grey_image.thumb.url)
            end
            column span: 2 do
              panel "Delete B&W Headshot" do
                f.check_box :remove_grey_image, as: :boolean, require: false
                para "Just want to remove the file? Check this and hit update."
              end
            end
          end
        end
        file_label = 'Replace B&W Headshot'
      end
      f.input :grey_image, as: :file, id: "preview_this_image",
                                label: file_label || "Upload B&W Headshot",
                                hint: "Maximum photo size is 15mb.",
                                input_html: {
                                  title: (f.object.grey_image? ?
                                          "Replace B&W" :
                                          "Upload B&W"
                                          ),
                                  data: {type: 'large_png'}
                                }
      f.hidden_field :grey_image_cache
      if f.object.color_image?
        panel "Current Color Headshot" do
          columns do
            column do
              image_tag f.object.color_image.thumb.url
            end
            column span: 2 do
              panel "Delete Color Headshot" do
                f.check_box :remove_color_image, as: :boolean, require: false
                para "Just want to remove the file? Check this and hit update."
              end
            end
          end
        end
        color_file_label = 'Replace Color Headshot'
      end
      f.input :color_image, as: :file, id: "preview_this_image",
                                label: color_file_label || "Upload Color Headshot",
                                hint: "Maximum photo size is 15mb.",
                                input_html: {
                                  title: (f.object.color_image? ?
                                          "Replace Color" :
                                          "Upload Color"
                                          ),
                                  data: {type: 'large_png'}
                                }
      f.hidden_field :color_image_cache
      f.input :bio, placeholder: "You can add basic html code here. That includes p tags which create a paragraph.", hint: "You can add a '<p>' tag to create a paragraph. Like this: '<p>I'm a paragraph!</p>'"
    end
      para "Adding a new headshot updates the site. So proof your work!"
      para "If you add a color photo, but not a black & white, then the color photo will be shown."
    f.actions
    puts params
  end

  index as: :grid do |headshot|
    div do
      link_to image_tag(headshot.grey_image.thumb), admin_headshot_path(headshot)
    end
    a truncate(headshot.full_name), :href => admin_headshot_path(headshot)
    span "Priority: #{headshot.priority}"
  end

  show do
    attributes_table do
      row :brand do |f|
        f.brand.name
      end
      row :first_name
      row :last_name
      row :title
      row :created_at
      row :updated_at
      row :Thumb_Nail do |f|
        image_tag(f.grey_image.url(:thumb)).html_safe
      end
      row :Thumb_Nail do |f|
        image_tag(f.color_image.url(:thumb)).html_safe
      end
      row :bio
      active_admin_comments
    end
  end

  controller do
    def scoped_collection
      end_of_association_chain.includes(:brand).references(:brand)
    end
  end

end
