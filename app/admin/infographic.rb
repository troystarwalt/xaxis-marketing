ActiveAdmin.register Infographic do
menu parent: "Platforms"
permit_params :name, :description, :image_preview, :file, :platform_id

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
    f.inputs "Create a New Inforgraphic Accessory" do
      f.input :platform, as: :radio
      f.input :name, placeholder: "Name of Infographic"
      f.input :description
      f.input :image_preview, as: :file
      f.input :file, as: :file
    end
    f.actions
  end

end
