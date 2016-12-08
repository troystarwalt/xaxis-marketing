# frozen_string_literal: true
ActiveAdmin.register OneSheeter do
menu false
permit_params :name, :file, :platform_id
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
    f.inputs "Create a New One Sheeter" do
      f.input :platform, as: :radio
      f.input :name, placeholder: "Name of One-Sheeter"
      f.input :file, as: :file
    end
    f.actions
  end
  show do
    attributes_table do
      row :name
      row :file do |f|
        link_to f.file_identifier, f.file_url, target: "_blank"
      end
      row :platform
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

end
