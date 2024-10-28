class WagonPassenger < Wagon

  #attr_accessor :seats_in_wagon

  def initialize(number_of_seats)
    @number_of_seats = number_of_seats
    @seats_in_wagon = {}
    @type = :passenger
    create_seats
    super()
  end


  def takes_up
    @seats_in_wagon.each do |k, v|
      if v == false
        @seats_in_wagon[k] = true
        break
      end
    end
  end

  def occupied_seats
    occupied_seat = 0
    @seats_in_wagon.each do |k, v|
      if v == false
        occupied_seat = k.to_i - 1
        break
      end
    end
    return occupied_seat
  end

  def free_seats
    @seats_in_wagon.length.to_i - occupied_seats.to_i
  end

  private
  def create_seats
    val = 0
    @number_of_seats.to_i.times { @seats_in_wagon[val += 1] = false }
  end

end