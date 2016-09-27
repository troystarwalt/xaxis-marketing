ActiveAdmin.register Logo do
  permit_params :name, :file, :brand_id

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters

  form do |f|
    f.inputs "New Logo" do
      f.input :name
      f.input :brand_id, as: :select, :collection => Hash[Brand.all.map{|b| [b.name, b.id]}]
      f.input :file
      f.input :author, as: "hidden", :input_html => { value: f.current_admin_user.email }
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
      row :author
      active_admin_comments
    end
  end

end
