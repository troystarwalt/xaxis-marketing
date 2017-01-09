# frozen_string_literal: true
ActiveAdmin.register Headshot do
  menu parent: "Brands"

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :first_name, :last_name, :title, :brand_id, :image, :priority, :bio
  #
  form :html => { :multipart => true } do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "New Headshot" do
      f.input :first_name, placeholder: "John"
      f.input :last_name, placeholder: "Smith"
      f.input :title, placeholder: "CFO"
      f.input :brand_id, as: :radio, :collection => Hash[Brand.all.map{|b| [b.name, b.id]}]
      f.input :priority, as: :select, :collection => Array(1..20), hint: "A person with Priority of 1 will be listed 1st"
      if f.object.image?
        panel "Current Headshot" do
          image_tag f.object.image.thumb.url
        end
        file_label = 'Replace Headshot'
      end
      f.input :image, as: :file, id: "preview_this_image",
                                label: file_label || "Upload Headshot",
                                hint: "Maximum photo size is 10mb.",
                                input_html: {
                                  title: (f.object.image? ?
                                          "Replace Image" :
                                          "Upload Image"
                                          ),
                                  data: {type: 'png'}
                                }
      f.hidden_field :image_cache
      f.input :bio, hint: "Need paragraphs? You can add a <br /> tag."
    end
      para "Adding a new headshot updates the site. So proof your work!"
    f.actions
    puts params
  end

  index as: :grid do |headshot|
    div do
      link_to image_tag(headshot.image.thumb), admin_headshot_path(headshot)
    end
    a truncate(headshot.full_name), :href => admin_headshot_path(headshot)
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
        image_tag(f.image.url(:thumb)).html_safe
      end
      row :Large_Version do |f|
        image_tag(f.image.url(:large)).html_safe
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
