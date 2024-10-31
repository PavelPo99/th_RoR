# frozen_string_literal: true

class WagonCargo < Wagon
  def initialize(total_volume)
    @type = :cargo
    super
  end

  def takes_volume(volume)
    @used_volume += volume
  end
end
