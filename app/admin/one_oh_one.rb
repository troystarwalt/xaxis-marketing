ActiveAdmin.register OneOhOne, as: "Series" do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters

menu label: "101 Series"
permit_params :name, :pdf_file, :ppt_file, :image_preview, :pdf_file_cache, :ppt_file_cache, :image_preview_cache

form :html => { :multipart => true } do |f|
  f.semantic_errors *f.object.errors.keys
  f.inputs "Create New 101 Series" do
    f.input :name, label: "101 Series Name", placeholder: "ex: Programmatic 101"
    # PPT FILE UPLOAD
    if f.object.ppt_file?
      panel "Current PPT" do
        para f.object.ppt_file.file.filename
      end
      ppt_label = 'Replace PPT'
    end
    f.input :ppt_file, as: :file,
            label: ppt_label || "Upload PPT",
            input_html: {
                        data: {type: 'ppt'},
                        title: (f.object.ppt_file? ? "Replace PPT" : "Upload PPT")},
            hint: "Max size of 100mb."
    # PDF FILE UPLOAD
    if f.object.pdf_file?
      panel "Current PDF" do
        para f.object.pdf_file.file.filename
      end
      pdf_label = 'Replace PDF'
    end
    f.input :pdf_file, as: :file,
            label: pdf_label || "Upload PDF",
            input_html: {
                        data: {type: 'pdf'},
                        title: (f.object.pdf_file? ? "Replace File" : "Upload File")},
            hint: "Max size of 10mb."
    # Imgae Preview
    if f.object.image_preview?
      panel "Current Preview" do
        image_tag f.object.image_preview.thumb.url
      end
      image_label = 'Replace Preview Image'
    end
    f.input :image, as: :file, id: "preview_this_image",
                              label: image_label || "Upload Preview Image",
                              hint: "Use first slide as preview. Max size is 5mb.",
                              input_html: {
                                title: (f.object.image_preview? ?
                                        "Replace File" :
                                        "Upload File"
                                        ),
                                data: {type: 'png'}
                              }
    f.hidden_field :image_preview_cache
    f.hidden_field :ppt_file_cache
    f.hidden_field :pdf_file_cache
    # f.input :image_preview, as: :file, input_html: {data: {type: 'png'}}, hint: "Use the image from the first slide. Max size of 5mb."
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
