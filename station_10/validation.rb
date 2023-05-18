module Validation
    def self.included(base)
      base.extend ClassMethods
    end
  
    module ClassMethods
      def validate(attr_name, validation_type, *args)
        @validations ||= []
        @validations << { attr_name: attr_name, type: validation_type, args: args }
      end
    end
  
    def validate!
        self.class.validations.each do |validation|
        attr_name = validation[:attr_name]
        type = validation[:type]
        args = validation[:args]
  
        send("validate_#{type}", attr_name, *args)
      end
    end
  
    def valid?
      validate!
      true
    rescue StandardError
      false
    end
  
    def validations
        self.class.instance_variable_get(:@validations) || []
    end      
      
    private
  
    def validate_presence(attr_name)
      value = instance_variable_get("@#{attr_name}")
      raise "#{attr_name} cannot be nil or empty" if value.nil? || value.to_s.empty?
    end
  
    def validate_format(attr_name, format)
      value = instance_variable_get("@#{attr_name}")
      raise "#{attr_name} has invalid format" unless value.to_s.match?(format)
    end
  
    def validate_type(attr_name, type)
      value = instance_variable_get("@#{attr_name}")
      raise "#{attr_name} has invalid type" unless value.is_a?(type)
    end
end
  