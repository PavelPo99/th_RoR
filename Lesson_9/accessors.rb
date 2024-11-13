module Acсessors

  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      variable_history = "@#{name}_history".to_sym
 
      define_method(name) { instance_variable_get(var_name) }  
      define_method("#{name}_history".to_sym) { instance_variable_get(variable_history)}

      define_method("#{name}=".to_sym) do |value| 
        instance_variable_set(var_name, value) 
        instance_variable_set(variable_history, (instance_variable_get(variable_history) || []) << value )
      end
    end


  end

  def strong_attr_accessor(name_attr, class_attr)
    var_name_attr = "@#{name_attr}".to_sym
    define_method("strong_#{name_attr}") { instance_variable_get(var_name_attr)}

    define_method("strong_#{name_attr}=") do |value|
      if value.class == class_attr
        instance_variable_set(var_name_attr, value)
      else
        raise TypeError, "Значение не присвоено! Класс (#{class_attr}) не соответсвует типу переменной (#{value.class})!"
      end
    end
  end
end