# frozen_string_literal: true

class WagonPassenger < Wagon

  superclass_validations

  def initialize(number_of_seats)
    @type = :passenger
    super
    validate!
  end

  def takes_seat
    @used_volume += 1
  end
end
