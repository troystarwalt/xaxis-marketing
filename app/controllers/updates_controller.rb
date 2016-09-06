class UpdatesController < ApplicationController
  def index
  end

  def show
    @update = Update.find(params[:id])
  end

  def new
    @update = Update.new
  end

  def create
    @update = Update.new(update_params)
    respond_to do |format|
      if @update.save
        format.js { render 'updates/create' }
        format.html { redirect_to root_path }
      else
        format.js { render 'updates/new' }
        format.html { render 'updates/new' }
        puts @update.errors.messages
      end
    end
  end

  def destroy
  end

  def main
    @updates = Update.all
  end

  def update_params
    params.require(:update).permit(:title, :text, :author)
  end
end
