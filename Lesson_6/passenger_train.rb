require_relative "instance_counter"

class PassengerTrain < Train
  include InstanceCounter

  def initialize(id_train)
    @type_train = :passenger
    super(id_train, type_train)
  end
end