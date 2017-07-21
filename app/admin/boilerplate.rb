ActiveAdmin.register Boilerplate do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
menu parent: "Brands"
permit_params :description, :brand_id

form do |f|
  f.semantic_errors(*f.object.errors.keys)
  f.inputs "Create your boilerplate here." do
    f.input :brand_id, as: :radio, :collection => Hash[Brand.all.map{|b| [b.name, b.id]}], required: true
    f.input :description, as: :text, placeholder: "You can add basic html code here. That includes anchor tags which generate a link.", hint: "Valid tags: <br />, <p>, <strong>, <ul>, <li>. Example: <a href='www.google.com'>Google</a>", required: true
  end
  f.actions
end

end
