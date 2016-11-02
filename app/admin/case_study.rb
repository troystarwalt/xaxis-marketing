ActiveAdmin.register CaseStudy do

  permit_params :title, :pdf_attachment, :platform_id, :author, :release_date, :short_description, :industry_list, region_list: []

  form :html => { :multipart => true } do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Create a New One Sheeter" do
      f.input :platform, as: :radio
      f.input :title, placeholder: "Name of Case Study"
      f.input :release_date, as: :datepicker
      f.input :short_description, placeholder: "Short Description for main case studies page"
      f.input :author, as: "hidden", :input_html => { value: f.current_admin_user.email }
      f.input :pdf_attachment, as: :file
      f.input :industry_list, label: "Industries <i>Separate With Commas</i>".html_safe, input_html: {"data-role" => 'tagsinput'}
      f.input :region_list, as: :select, input_html: {multiple: true, "data-role" => 'tagsinput'}, collection: CaseStudy.region_list
    end
    f.actions
  end


  show do
    attributes_table do
      row :title
      row :author
      row :release_date do |f|
        f.get_pretty_release_date
      end
      row :short_description
      row :pdf_attachment do |f|
        f.pdf_attachment_identifier
      end
      row :platform
      row :industries do |f|
        f.industry_list
      end
      row :regions do |f|
        f.region_list
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  index do
    selectable_column
    id_column
    column :author
    column :release_date
    column :short_description
    column :pdf_attachment do |f|
      f.pdf_attachment_identifier
    end
    column :platform
    column :industries do |f|
      f.industry_list
    end
    column :regions do |f|
      f.region_list
    end
    column :created_at
    column :updated_at
    actions
  end

end
