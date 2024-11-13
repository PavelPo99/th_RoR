# frozen_string_literal: true
require_relative 'validations'

class Wagon
  include CompanyName
  include Validation

  attr_reader :type, :used_volume, :total_volume
  
  validate :total_volume, :presence
  
  def initialize(total_volume)
    @total_volume = total_volume
    @used_volume = 0
  end

  def free_volume
    total_volume - used_volume
  end
end
