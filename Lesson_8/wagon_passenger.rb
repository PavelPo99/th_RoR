# frozen_string_literal: true

class WagonPassenger < Wagon
  def initialize(number_of_seats)
    @type = :passenger
    super
  end

  def takes_seat
    @used_volume += 1
  end
end
