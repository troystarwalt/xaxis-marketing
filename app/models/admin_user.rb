class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable


  # after_create { |admin| admin.send_reset_password_instructions }

  devise :database_authenticatable,
  :recoverable, :rememberable, :trackable, :validatable

  # def my_callback
  #   self.reload # refresh the model with right state
  #   save
  # end

  # def password_required?
  #   new_record? ? false : super
  # end
end
