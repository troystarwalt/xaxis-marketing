ActiveAdmin.register Video do
menu parent: "Platforms"
permit_params :name, :description, :direct_link, :embed_link, :image_preview, :platform_id
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
  f.inputs "Create a New video" do
    f.input :platform, as: :radio
    f.input :name, placeholder: "Video Name"
    f.input :description
    f.input :direct_link
    f.input :embed_link
  end
  f.actions
end

end
