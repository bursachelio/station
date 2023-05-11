# frozen_string_literal: true

require_relative 'vagon'

class CargoVagon < Vagon
  attr_accessor :volume, :occupied_volume

  def initialize(num_vagon, _type_vagon, manufacturer, volume)
    super(num_vagon, 'cargo', manufacturer)
    @volume = volume
    @occupied_volume = 0
  end

  def free_volume
    @volume - @occupied_volume
  end

  def load_cargo(amount)
    raise "Недостаточно вместимости для загрузки #{amount} единиц груза" if amount > free_volume

    @occupied_volume += amount
  end
end
