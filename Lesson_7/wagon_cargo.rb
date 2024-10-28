class WagonCargo < Wagon

  attr_reader :current_volume

  def initialize(total_volume)
    @total_volume = total_volume
    @current_volume = 0
    @type = :cargo
    super()
  end

  def occupied_volume(volume)
    @current_volume = volume
  end

  def free_volume
    return free_volum = @total_volume.to_i - @current_volume.to_i
  end
end