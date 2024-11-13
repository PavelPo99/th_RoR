# frozen_string_literal: true

require_relative 'instance_counter'

class CargoTrain < Train
  include InstanceCounter

  superclass_validations

  def initialize(id_train)
    @type_train = :cargo
    super(id_train, type_train)
  end
end
