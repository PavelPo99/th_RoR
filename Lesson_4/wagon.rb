class Wagon
  attr_reader :type, :id_wagon
  
  def initialize(id_wagon, type)
    @id_wagon = id_wagon
    @type = type
  end
end


