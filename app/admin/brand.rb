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
    end
    active_admin_comments
end

  form do |f|
    para "Ask yourself...do you REALLY want to add a new Brand?"
    f.semantic_errors *f.object.errors.keys
    f.inputs 'You can add a new Brand here.' do
      f.input :name, label: 'Brand Name', :placeholder => "Again...you probably do not want to create a new brand."
      f.input :author, as: "hidden", :input_html => { value: f.current_admin_user.email }
    end
    f.actions
  end
end
