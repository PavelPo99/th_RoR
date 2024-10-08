require_relative "train"

class PassengerTrain < Train
  attr_accessor :id_train
  
  def initialize(id_train)
    super(id_train, 'passenger')
  end
end