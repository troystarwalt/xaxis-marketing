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
    if brand.logos.empty?
      panel "Logos" do
        status_tag "There are no logos associated with this brand."
      end
    else
      panel "Logos" do
        table_for brand.logos do
          column :name do |checkit|
            link_to checkit.name, admin_logo_path(checkit)
          end
          column :file_identifier
          column :created_at
        end
      end
    end
    active_admin_comments
  end
end

  form do |f|
    f.inputs 'You can add a new Brand here.' do
      f.input :name, label: 'Brand Name'
      f.input :author, as: "hidden", :input_html => { value: f.current_admin_user.email }
    end
    f.actions
  end
end
