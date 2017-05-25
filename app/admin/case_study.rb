# frozen_string_literal: true
ActiveAdmin.register CaseStudy do
menu false
  permit_params :title, :pdf_attachment, :author, :release_date, :short_description, :industry_list, region_list: []

  form :html => { :multipart => true } do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Create a New One Sheeter" do
      f.input :title, placeholder: "Name of Case Study"
      f.input :release_date, as: :datepicker,
                              input_html: {
                                value: (f.object.release_date ?
                                        f.object.get_date_picker_release_date :
                                        Date.today)
                              }
      f.input :short_description, placeholder: "Short Description for main case studies page"
      f.input :author, as: "hidden",
                        input_html: {
                          value: f.current_admin_user.email
                        }
      if f.object.pdf_attachment?
        f.input :current_pdf_attachment, input_html: {
                                            value: f.object.pdf_attachment_identifier,
                                            disabled: true
                                        }
        file_label = 'Replace PDF Attachment'
      end
      f.input :pdf_attachment, as: :file,
                                label: file_label || "Upload PDF Attachment",
                                input_html: {
                                  title: (f.object.pdf_attachment? ?
                                          "Replace File" :
                                          "Upload File"
                                          )
                                }
      f.input :industry_list, label: "Industries <i>Separate With Commas</i>".html_safe,
                              input_html: {
                                value: f.object.industry_list.join(", "),
                                class: 'tagsinput',
                                "data-role" => 'tagsinput',
                                placeholder: 'Add Industries'
                              }
      f.input :region_list, label: "Regions",
                            as: :select,
                            input_html: {
                              multiple: true,
                              class: 'select2',
                                placeholder: "Select Regions"
                            },
                            collection: CaseStudy::REGION_LIST
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
        link_to f.pdf_attachment_identifier, f.pdf_attachment_url, target: '_blank'
      end
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
