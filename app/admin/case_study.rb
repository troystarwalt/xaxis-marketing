ActiveAdmin.register CaseStudy do

  permit_params :title, :pdf_attachment, :platform_id, :author, :release_date, :short_description, :industry_list

  before_save do |model|
    puts "casing"
    puts model.industry_list
    model.industry_list = model.industry_list.map{|industry| industry.capitalize}.join(',')
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form :html => { :multipart => true } do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Create a New One Sheeter" do
      f.input :platform, as: :radio
      f.input :title, placeholder: "Name of Case Study"
      f.input :release_date, as: :datepicker
      f.input :short_description, placeholder: "Short Description for main case studies page"
      f.input :author, as: "hidden", :input_html => { value: f.current_admin_user.email }
      f.input :pdf_attachment, as: :file
      f.input :industry_list, label: "Industries <i>Separate With Commas</i>".html_safe, input_html: {value: f.object.industry_list.join(", ")}
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
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

end
