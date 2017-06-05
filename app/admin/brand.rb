# frozen_string_literal: true
ActiveAdmin.register Brand do

  menu priority: 2
  skip_before_action :get_our_brands


  permit_params :name, :main_nav, :presentation_hub

  config.filters = false

  sidebar :brand, only: :show do
    ul do
      li brand.name
      li "Created on #{brand.pretty_date}"
      li brand.main_nav? ? "Included in Main Navigation" : "Not Included in Main Navigation"
      li brand.presentation_hub? ? "Included in Presentation Hub" : "Not Included in Presentation Hub"
    end
  end

  index do
    selectable_column
    column :name
    column :main_nav
    column :presentation_hub
    column :created_at
    column :updated_at
    actions
  end



  controller do
    def find_resource
      scoped_collection.where(slug: params[:id]).first!
    rescue ActiveRecord::RecordNotFound
      scoped_collection.find(params[:id])
    end
  end
  show do
    para "#{brand.name}'s Assets and Accessories"
    panel 'PPT Template' do
      table_for brand.brand_accessories.where(category: 'ppt_template') do
        column :name
        column :file, &:file_url
        column :link do |f|
          link_to('View', admin_brand_accessory_path(f.id))
        end
      end
    end

    panel 'Word Temmplate' do
      table_for brand.brand_accessories.where(category: 'word_template') do
        column :name
        column :file, &:file_url
        column :link do |f|
          link_to('View', admin_brand_accessory_path(f.id))
        end
      end
    end

    panel 'Guidelines' do
      table_for brand.brand_accessories.where(category: 'guidelines') do
        column :name
        column :file, &:file_url
        column :link do |f|
          link_to('View', admin_brand_accessory_path(f.id))
        end
      end
    end

    panel 'All Logos' do
      table_for brand.brand_accessories.where(category: 'logo') do
        column :name
        column :file, &:file_url
        column :link do |f|
          link_to('View', admin_brand_accessory_path(f.id))
        end
      end
    end

    panel 'Capability' do
      table_for brand.brand_accessories.where(category: 'capability') do
        column :name
        column :file, &:file_url
        column :link do |f|
          link_to('View', admin_brand_accessory_path(f.id))
        end
      end
    end

    panel 'Facts' do
      table_for brand.brand_accessories.where(category: 'facts') do
        column :name
        column :file, &:file_url
        column :link do |f|
          link_to('View', admin_brand_accessory_path(f.id))
        end
      end
    end
    panel 'Headers' do
      table_for brand.brand_accessories.where(category: 'header') do
        column :name
        column :file, &:file_url
        column :link do |f|
          link_to('View', admin_brand_accessory_path(f.id))
        end
      end
    end
    panel 'Stickers' do
      table_for brand.brand_accessories.where(category: 'sticker') do
        column :name
        column :file, &:file_url
        column :link do |f|
          link_to('View', admin_brand_accessory_path(f.id))
        end
      end
    end
    panel 'Rollups' do
      table_for brand.brand_accessories.where(category: 'rollup') do
        column :name
        column :file, &:file_url
        column :link do |f|
          link_to('View', admin_brand_accessory_path(f.id))
        end
      end
    end
    panel 'Videos' do
      table_for brand.videos.each do
        column :name
        column :image_preview
        column :link do |f|
          link_to('View', admin_video_path(f.id))
        end
      end
    end
  end

  form do |f|
    para 'Ask yourself...do you REALLY want to add a new Brand?'
    f.semantic_errors(*f.object.errors.keys)
    f.inputs 'You can add a new Brand here.' do
      f.input :name, label: 'Brand Name', placeholder: 'Again...you probably do not want to create a new brand.'
      f.input :author, as: 'hidden', input_html: { value: f.current_admin_user.email }
      f.input :main_nav, label: "Include in Main Navigation?"
      f.input :presentation_hub, label: "Included in Presentation Hub?"
    end
    f.actions
  end
end
