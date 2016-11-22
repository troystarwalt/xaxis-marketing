class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    respond_to do |format|
      if @contact.save
        puts "saved"
        format.html { redirect_to(root_path, notice: 'Feedback sent!')}
        format.json { render json: @contact, status: :creatd, location: @contact}
      else
        format.html { render action: 'new'}
        format.json { render json: @contact.errors, status: :unprocessable_entity}
      end
    end
  end

  private
  def contact_params
    params.require(:contact).permit(:name, :email, :message, :rating)
  end
end
