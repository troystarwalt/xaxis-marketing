ActiveAdmin.register Post do

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

  permit_params :title, :text, :author, :tag_list => []

    index do
      selectable_column
      id_column
      column :title
      column :text
      column :author
      column :tag_list
      column :created_at
      column :updated_at
      actions
    end

  filter :title
  filter :tag_list
  filter :text
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs "New Post" do
      f.input :title
      f.input :text
      f.input :author, type: "hidden", value: "current_admin_user.email"
      f.input :tag_list,
        as: :select,
        multiple: :true,
        collection: ["News", "Announcement", "Event"]
    end
    f.actions
  end
end
