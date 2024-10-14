require_relative "instance_counter"

class CargoTrain < Train
  include InstanceCounter
  
  def initialize(id_train)
    @type_train = :cargo
    super(id_train, type_train)
  end
end