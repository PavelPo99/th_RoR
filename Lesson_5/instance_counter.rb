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


  # module ClassMethods 
  #   def instances 
  #     @instances ||= 0
  #   end 
  #   def increment_instance_count 
  #     @instances = instances + 1
  #   end end

  # module InstanceMethods
  #   private

  #   def register_instance 
  #     self.class.increment_instance_count
  #   end
  # end

end