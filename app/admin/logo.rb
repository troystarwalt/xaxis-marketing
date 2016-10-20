ActiveAdmin.register Logo do
menu parent: "Platforms"
permit_params :name, :file, :platform_id
batch_action :destroy, confirm: "Are you sure??"

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
    f.inputs "Create a Logo" do
      f.input :platform, as: :radio
      f.input :name, placeholder: "Name of Logo"
      span "Should be either .PNG or .EPS"
      f.input :file, as: :file
    end
    f.actions
  end


end
