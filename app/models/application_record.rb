# frozen_string_literal: true
require 'file_size_validator'

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  scope :last_three, -> {order(created_at: :desc).first(3)}

  def pretty_date
    created_at.to_date.strftime("%m\/\%d\/\%Y")
  end

  def is_recent
    (Date.today - 10.days) <= updated_at
  end

  # def last_two
  #   order("created_at DESC").first(2)
  # end
end
