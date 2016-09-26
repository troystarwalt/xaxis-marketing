ActiveAdmin.register Logo do
  permit_params :name, :file, :brand_id

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters

  form do |f|
    f.inputs "New Logo" do
      f.input :name
      f.input :brand_id, as: :select, :collection => Hash[Brand.all.map{|b| [b.name, b.id]}]
      f.input :file
    end
    f.actions
    puts params
  end

end
