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

  index do
    selectable_column
    id_column
    column :name
    column :created_at
    column :updated_at
    column :file do |f|
      image_tag(f.file.url).html_safe
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
        image_tag(f.file.url).html_safe
      end
      active_admin_comments
    end
  end
end
