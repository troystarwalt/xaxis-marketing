# frozen_string_literal: true
ActiveAdmin.register Brand do
  skip_before_action :get_our_brands
  permit_params :name

  config.filters = false

  sidebar :brand, only: :show do
    ul do
      li brand.name
      li "Created on #{brand.pretty_date}"
    end
  end

  index do
    selectable_column
    column :name
    column :created_at
    column :updated_at
    actions
  end
  #
  # index as: :grid do |brand|
  #   link_to brand.name, admin_brand_path(brand)
  # end


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

    panel 'Font' do
      table_for brand.brand_accessories.where(category: 'font') do
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
    panel 'Palette' do
      table_for brand.brand_accessories.where(category: 'palette') do
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
  end

  form do |f|
    para 'Ask yourself...do you REALLY want to add a new Brand?'
    f.semantic_errors(*f.object.errors.keys)
    f.inputs 'You can add a new Brand here.' do
      f.input :name, label: 'Brand Name', placeholder: 'Again...you probably do not want to create a new brand.'
      f.input :author, as: 'hidden', input_html: { value: f.current_admin_user.email }
    end
    f.actions
  end
end
