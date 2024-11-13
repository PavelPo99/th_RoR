# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_accessor :instances
  end

  module InstanceMethods
    private

    def register_instance
      self.class.instances = (self.class.instances || 0) + 1
    end
  end
end
