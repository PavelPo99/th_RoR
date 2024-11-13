# frozen_string_literal: true

require_relative 'instance_counter'

class PassengerTrain < Train
  include InstanceCounter

  superclass_validations

  def initialize(id_train)
    @type_train = :passenger
    
    super(id_train, type_train)
  end
end
