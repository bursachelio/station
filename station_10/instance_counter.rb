# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.instance_variable_set(:@instances, 0)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def instances
      @instances ||= 0
    end

    def increment_instance
      @instances ||= 0
      @instances += 1
    end
  end

  def register_instance
    self.class.increment_instance
  end
end
