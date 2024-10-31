# frozen_string_literal: true

class Wagon
  include CompanyName
  attr_reader :type, :used_volume, :total_volume

  def initialize(total_volume)
    @total_volume = total_volume
    @used_volume = 0
  end

  def free_volume
    total_volume - used_volume
  end
end
