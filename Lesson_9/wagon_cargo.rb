# frozen_string_literal: true

class WagonCargo < Wagon

  superclass_validations

  def initialize(total_volume)
    @type = :cargo
    super
    validate!
  end

  def takes_volume(volume)
    @used_volume += volume
  end
end
