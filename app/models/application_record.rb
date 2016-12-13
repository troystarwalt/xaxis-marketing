# frozen_string_literal: true
require 'file_size_validator'

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def pretty_date
    created_at.to_date.strftime("%m\/\%d\/\%Y")
  end

end
