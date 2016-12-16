ActiveAdmin.register OneOhOne, as: "Series" do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters

menu label: "101 Series"
permit_params :name, :pdf_file, :ppt_file, :image_preview

form :html => { :multipart => true } do |f|
  f.semantic_errors *f.object.errors.keys
  f.inputs "Create New 101 Series" do
    f.input :name, label: "101 Series Name", placeholder: "ex: Programmatic 101"
    f.input :ppt_file, as: :file, input_html: {data: {type: 'ppt'}}, hint: "Max size of 100mb."
    f.input :pdf_file, as: :file, input_html: {data: {type: 'pdf'}}, hint: "Max size of 5mb."
    f.input :image_preview, as: :file, input_html: {data: {type: 'png'}}, hint: "Use the image from the first slide. Max size of 5mb."
  end
  f.actions
end

  index do
    selectable_column
    id_column
    column :name
    column :ppt_file do |f|
      f.ppt_file_identifier
    end
    column :pdf_file do |f|
      f.pdf_file_identifier
    end
    column :image_preview do |f|
      if f.image_preview.file.nil?
        image_tag f.image_preview_url, class: "admin_show_image"
      else
        image_tag f.image_preview.thumb, class: "admin_show_image"
      end
    end
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :ppt_file do |f|
        f.ppt_file_identifier
      end
      row :pdf_file do |f|
        f.pdf_file_identifier
      end
      row :image_preview do |f|
        if f.image_preview.file.nil?
          image_tag f.image_preview_url, class: "admin_show_image"
        else
          image_tag f.image_preview.thumb, class: "admin_show_image"
        end
      end
      row :created_at
      row :updated_at
    end

  end


end
