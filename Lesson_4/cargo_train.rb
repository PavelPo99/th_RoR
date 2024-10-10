class CargoTrain < Train
  
  def initialize(id_train)
    @type_train = :cargo
    super(id_train, type_train)
  end
end