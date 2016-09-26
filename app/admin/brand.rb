ActiveAdmin.register Brand do
permit_params :name

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
# for use if we want to allow uploading a logo when creating a new brand
# f.inputs do
#   f.has_many :logos, allow_destroy: true, new_record: true do |a|
#     a.input :name
#     a.input :file
#   end
# end

show do
  attributes_table do
    row :id
    row :name
    row :created_at
    row :updated_at
    panel "Logos" do
      table_for brand.logos do
        column :name
        column :file_url
      end
    end
    active_admin_comments
  end
end

  form do |f|
    f.inputs 'You can add a new Brand here.' do
      f.input :name, label: 'Brand Name'
    end
    f.actions
  end
end
