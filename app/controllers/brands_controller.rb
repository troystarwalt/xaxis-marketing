# frozen_string_literal: true
class BrandsController < InheritedResources::Base
  actions :index, :show   # This tells InheritedResources to only use index and show.
  helper_method :remove_dash_make_symbol


  def index
    brand = Brand.find_by!(:name => 'Xaxis')
    redirect_to brand_path(brand.slug)
  end

  def show
    @brand = Brand.friendly.find(params[:id])
    # gon.headshots = @brand.headshots.ordered_by_priority

    @headshots = Headshot.where(brand_id: @brand.id).ordered_by_priority
    gon.headshots = @headshots
    @image_bank = GlobalAccessory.where(category: 'image_bank').last  # Get the most recent image bank download
    brand_accessories_zip = @brand.brand_accessories.where(category: ['guidelines', 'logo', 'palette'])
    @pr_kit = GlobalAccessory.where(category: 'pr_kit').last  # Get the brands pr kit
    @content = helpers.content_for_brands[remove_dash_make_symbol(@brand.slug)]  # Pull in text content for each brand

    # Take the assets and zip them up for the user.
    respond_to do |format|
      format.html
      format.zip { send_data ZipContentService.new(brand_accessories_zip).zip_files_please }
    end
  end

  protected

  def remove_dash_make_symbol(s)
    s.gsub('-', '').to_sym
  end

  private


  def brand_params
    params.require(:brand).permit(:name)
  end
end
