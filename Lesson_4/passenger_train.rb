class PassengerTrain < Train

  def initialize(id_train)
    @type_train = :passenger
    super(id_train, type_train)
  end
end