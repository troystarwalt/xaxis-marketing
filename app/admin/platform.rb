ActiveAdmin.register Platform do

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
  sidebar :Platform, only: :show do
    ul do
      li platform.name
      li "Created on #{platform.pretty_date}"
    end
  end

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
    panel "One Sheeter(s))" do
      table_for platform.one_sheeters do
        column :name
        column :file
        column :link do |f|
          link_to("View", admin_one_sheeter_path(f.id))
        end
      end
    end

    panel "Logos" do
      table_for platform.logos do
        column :name
        column :file
        column :link do |f|
          link_to("View", admin_logo_path(f.id))
        end
      end
    end
    panel "Infographics" do
      table_for platform.infographics do
        column :name
        column :image_preview do |f|
          image_tag(f.image_preview, class: "admin_show_image")
        end
        column :link do |f|
          link_to("View", admin_infographic_path(f.id))
        end
      end
    end
    panel "Videos" do
      table_for platform.videos do
        column :name
        column :file
        column :image_preview do |f|
          image_tag(f.image_preview, class: "admin_show_image")
        end
        column :link do |f|
          link_to("View", admin_video_path(f.id))
        end
      end
    end
  end
end
