class BrandsController < InheritedResources::Base
  require 'zip'
  around_filter :catch_not_found

  def index
    # Not using index for anything at this time.
    @brands = Brand.all
  end

  def show
    @brand = Brand.friendly.find(params[:id])
    @logos = Logo.where(:brand_id => params[:id])
    # Makes zip file out of logos. Will need to refactor this as there are multiple
    # Places where we will be collecting zips.
    respond_to do |format|
      format.html
      format.zip do
        @compressed_filestream = Zip::OutputStream.write_buffer do |zos|
          @logos.each do |logo|
            path = logo.file_identifier
            zos.put_next_entry(path)
            zos.write logo.file.read
          end
        end
        @compressed_filestream.rewind
        send_data @compressed_filestream.read, filename: "logos.zip"
      end
    end
  end
  private
    def brand_params
      params.require(:brand).permit(:name)
    end

    def catch_not_found
      yield
    rescue ActiveRecord::RecordNotFound
      redirect_to root_url
      puts "oh not found"
    end
end

# Since Rails 5 must use Inherited Resources with Active Admin
# I've provided a basic look at a controller that isn't using Inherited Resources.
# Personally don't love it, but it does make clean controllers.

  # def index
  #   @products = Product.all
  # end
  #
  # def show
  #   @product = Product.find(params[:id])
  # end
  #
  # def new
  #   @product = Product.new
  # end
  #
  # def create
  #   @product = Product.new(params[:product])
  #   if @product.save
  #     flash[:notice] = "Successfully created product."
  #     redirect_to @product
  #   else
  #     render :action => 'new'
  #   end
  # end
  #
  # def edit
  #   @product = Product.find(params[:id])
  # end
  #
  # def update
  #   @product = Product.find(params[:id])
  #   if @product.update_attributes(params[:product])
  #     flash[:notice] = "Successfully updated product."
  #     redirect_to @product
  #   else
  #     render :action => 'edit'
  #   end
  # end
  #
  # def destroy
  #   @product = Product.find(params[:id])
  #   @product.destroy
  #   flash[:notice] = "Successfully destroyed product."
  #   redirect_to products_url
  # end
