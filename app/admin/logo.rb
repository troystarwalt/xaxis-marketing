ActiveAdmin.register Logo do
  permit_params :name, :file, :brand_id

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters

  form :html => { :multipart => true } do |f|
    f.inputs "New Logo" do
      f.input :name
      f.input :brand_id, as: :select, :collection => Hash[Brand.all.map{|b| [b.name, b.id]}]
      f.input :file, as: :string, required: false, hint: image_tag(object.file.url(:thumb)).html_safe unless object.file.blank?
      f.input :file
      f.hidden_field :file_cache
    end
    f.actions
    puts params
  end

  show do
    attributes_table do
      row :id
      row :name
      row :created_at
      row :updated_at
      active_admin_comments
    end
  end
end
