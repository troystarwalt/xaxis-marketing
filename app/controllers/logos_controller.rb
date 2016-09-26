class LogosController < ApplicationController
  def new
  end

  def create
  end

  def delete
  end

  private
    def logo_params
      params.require(:logo).permit(:name, :file )
    end
end
