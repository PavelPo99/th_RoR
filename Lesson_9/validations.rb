module Validation
  
  def self.included(base)
    base.extend ValidationClassMethod
    base.include ValidationInstanceMethod
  end

  module ValidationClassMethod
    def validate(attribute, type, args = nil)
      name_hash = { attribute: attribute, type: type, args: args }
      instance_variable_set('@validations', (instance_variable_get('@validations') || []) << name_hash)
    end

    def superclass_validations
      instance_variable_set('@validations', superclass.instance_variable_get('@validations'))
    end
  end

  module ValidationInstanceMethod
    def validate!
      self.class.instance_variable_get('@validations').each do |value|
        attribute_value = self.send(value[:attribute])
        if value[:args] 
          send(value[:type], attribute_value, value[:args]) 
        else
          send(value[:type], attribute_value)
        end
      end
    end

    def valid?
      validate!
      true
      rescue RuntimeError
        false
    end

    protected 

    def presence(attribute)
      raise "Значение атрибута '#{attribute}' не должно быть nil или пустой строкой!" if attribute.nil? || (attribute.respond_to?('empty?') && attribute.empty?)
    end

    def format(attribute, regex)
      raise "Не соответствие значения атрибута '#{attribute}' заданному регулярному выражению!" unless attribute.is_a?(String) && attribute =~ regex
    end

    def type(attribute, options)
      raise "Не соответствие значения атрибута '#{attribute.to_s}' заданному классу #{options}!" if attribute.class != options
    end
  end  
end