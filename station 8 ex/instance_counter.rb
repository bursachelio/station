module InstanceCounter

    def self.included(base)
      base.extend ClassMethods
      base.include InstanceMethods
      base.class_variable_set(:@@instances, 0)
    end
  
    module ClassMethods
      def instances
        class_variable_get(:@@instances)
      end
    end
  
    module InstanceMethods
  
      private
  
      def register_instance
        self.class.class_variable_set(:@@instances, self.class.instances + 1)
      end
    end
end