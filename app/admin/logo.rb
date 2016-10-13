ActiveAdmin.register Logo do
  permit_params :name, :file, :brand_id

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters

  form :html => { :multipart => true } do |f|
    f.inputs "Updated ZIP File of Logos" do
      f.input :name
      f.input :brand_id, as: :select, :collection => Hash[Brand.all.map{|b| [b.name, b.id]}]
      f.input :file
    end
    f.actions
    puts params
  end

  index do
    selectable_column
    id_column
    column :name
    column :created_at
    column :updated_at
    column :file do |f|
      f.file_identifier
    end
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :created_at
      row :updated_at
      row :file do |f|
        f.file_identifier
      end
      active_admin_comments
    end
  end
end

    # Easy setup if we switch back to allowing users to upload images and not .zip
    # column :file do |f|
    #   if file_is_image?(f.file_identifier)
    #     image_tag(f.file.url).html_safe
    #   else
    #     f.file_identifier
    #   end
    # end
