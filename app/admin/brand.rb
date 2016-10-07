ActiveAdmin.register Brand do
permit_params :name

controller do
  def find_resource
    begin
      scoped_collection.where(slug: params[:id]).first!
    rescue ActiveRecord::RecordNotFound
      scoped_collection.find(params[:id])
    end
  end
end


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
