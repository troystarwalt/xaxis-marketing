ActiveAdmin.register Video do
menu parent: "Platforms"
permit_params :name, :description, :direct_link, :embed_link, :image_preview, :platform_id

before_save do |video|
  get_link = VideoThumb::get(video.direct_link)
  video.image_preview = get_link
  byebug
end

form :html => { :multipart => true } do |f|
  f.semantic_errors *f.object.errors.keys
  f.inputs "Create a New video" do
    f.input :platform, as: :radio
    f.input :name, placeholder: "Video Name"
    f.input :description
    f.input :direct_link
    # f.input :remote_preview_image_url, as: "hidden", :input_html => { value: woot } do
    #   woot = VideoThumb::get(params[:direct_link])
    # end
    f.input :embed_link
  end
  f.actions
end

end
