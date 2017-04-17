# frozen_string_literal: true
class BrandsController < InheritedResources::Base
  require 'zip'
  actions :index, :show   # This tells InheritedResources to only use index and show.
  helper_method :remove_dash_make_symbol


  def index
    brand = Brand.find_by!(:name => 'Xaxis')
    redirect_to brand_path(brand.slug)
  end

  def show
    if params[:id] == "one-xaxis"
      @brand = Brand.includes(:brand_accessories, :videos).friendly.find(params[:id])
      get_content()
    else
      @brand = Brand.includes(:headshots, :brand_accessories).friendly.find(params[:id])
      gon.headshots = @brand.headshots.ordered_by_priority
      @image_bank = GlobalAccessory.where(category: 'image_bank').last  # Get the most recent image bank download
      brand_accessories_zip = @brand.brand_accessories.where(category: ['guidelines', 'logo', 'palette'])
      @pr_kit = GlobalAccessory.where(category: 'pr_kit').last  # Get the brands pr kit
    end
    @content = helpers.content_for_brands[remove_dash_make_symbol(@brand.slug)]  # Pull in text content for each brand

    # Take the assets and zip them up for the user.
    respond_to do |format|
      format.html
      format.zip do
        stringio = Zip::OutputStream.write_buffer do |zos|
          brand_accessories_zip.each do |stuff|
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

  protected
    def get_content
      @other_content = helpers.content_for_brands
    end

    def remove_dash_make_symbol(s)
      s.gsub('-', '').to_sym
    end

  private
    def brand_params
      params.require(:brand).permit(:name)
    end
end
