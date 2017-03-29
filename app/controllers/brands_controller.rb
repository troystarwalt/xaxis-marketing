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
    @brand = Brand.friendly.find(params[:id])  #Get Brand from params
    brand_for_content = @brand.slug.gsub('-','').to_sym   #if brand has a -, then remove it
    @content = helpers.content_for_brands[brand_for_content.to_sym]  # Pull in text content for each brand
    @brands = Brand.all # Get all brands for sub-nav
    @headshots = Headshot.where(brand_id: @brand.id).ordered_by_priority  # Get headshots and sort them by priority
    gon.headshots = @headshots  # Make headshots accessible in gon gem
    @image_bank = GlobalAccessory.where(category: 'image_bank').last  # Get the most recent image bank download
    @group = BrandAccessory.where(category: ['guidelines', 'logo', 'palette'], brand_id: @brand.id)  # Pull together brand assets to prepare for zip
    @pr_kit = GlobalAccessory.where(category: 'pr_kit').last  # Get the brands pr kit

    # Take the assets and zip them up for the user.
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
