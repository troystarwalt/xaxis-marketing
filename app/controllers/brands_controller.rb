# frozen_string_literal: true
class BrandsController < InheritedResources::Base
  require 'zip'
  actions :index, :show   # This tells InheritedResources to only use index and show.


  def index
    # Not using index for anything at this time.
    @brands = Brand.all
    brand = Brand.find_by!(:name => 'Xaxis')
    redirect_to brand_path(brand.slug)
  end

  def show
    @brand = Brand.friendly.find(params[:id])
    brand_for_content = @brand.slug.gsub('-','').to_sym
    @content = helpers.content_for_brands[brand_for_content.to_sym]
    @brands = Brand.all
    @headshots = Headshot.where(brand_id: @brand.id).ordered_by_priority
    gon.headshots = @headshots
    @image_bank = GlobalAccessory.where(category: 'image_bank').last
    @group = BrandAccessory.where(category: ['guidelines', 'logo', 'palette'], brand_id: @brand.id)
    @pr_kit = GlobalAccessory.where(category: 'pr_kit').last

    respond_to do |format|
      format.html
      format.zip do
        stringio = Zip::OutputStream.write_buffer do |zos|
          @group.each do |stuff|
            path = stuff.file_identifier
            zos.put_next_entry(path)
            zos.write stuff.file.read
          end
          puts stringio
        end
        stringio.rewind
        send_data stringio.read
      end
    end
  end

  private

    def brand_params
      params.require(:brand).permit(:name)
    end
end
