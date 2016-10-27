class BrandsController < InheritedResources::Base
  require 'zip'
  actions :index, :show   # This tells InheritedResources to only use index and show.
  around_filter :catch_not_found

  def index
    # Not using index for anything at this time.
    @brands = Brand.all
    brand = Brand.find_by(:name => "Xaxis")
    redirect_to brand_path(brand.id)
  end

  def show
    @brand = Brand.friendly.find(params[:id])
    @brands = Brand.all
    @headshots = Headshot.where(brand_id: @brand.id)
    image_bank_check = GlobalAccessory.where(category: "image_bank").present?
    if image_bank_check.present? && !image_bank_check.nil?
      @image_bank = GlobalAccessory.where(category: "image_bank").last.file_url
    end

    # Makes zip file out of logos. Will need to refactor this as there are multiple
    # Places where we will be collecting zips.
    # respond_to do |format|
    #   format.html
    #   format.zip do
    #     @compressed_filestream = Zip::OutputStream.write_buffer do |zos|
    #       @logos.each do |logo|
    #         path = logo.file_identifier
    #         zos.put_next_entry(path)
    #         zos.write logo.file.read
    #       end
    #     end
    #     @compressed_filestream.rewind
    #     send_data @compressed_filestream.read, filename: "logos.zip"
    #     byebug
    #   end
    # end
  end

  private
    def brand_params
      params.require(:brand).permit(:name)
    end
end
