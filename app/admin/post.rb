ActiveAdmin.register Post do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  menu priority: 2, label: proc { I18n.t "news"}

  permit_params :title, :text, :author, :tag_list => []

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end

    index do
      selectable_column
      id_column
      column :title
      column :text
      column :author
      column :tag_list
      column :image do |f|
        image_tag(f.image.url(:thumb)).html_safe
      end
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
      f.input :author, as: "hidden", :input_html => { value: f.current_admin_user.email }
      f.input :image, as: :file, label: "Main Image"
      f.input :tag_list,
        as: :select,
        multiple: :true,
        collection: Post.valid_tags
    end
    f.actions
  end
end
