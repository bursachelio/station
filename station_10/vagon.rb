# frozen_string_literal: true

require_relative 'manufacturer'

class Vagon
  include Manufacturer
  attr_accessor :num_vagon, :type_vagon, :manufacturer

  def initialize(num_vagon, type_vagon, manufacturer)
    @num_vagon = num_vagon
    @type_vagon = type_vagon
    @manufacturer = manufacturer
    validate!
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  private

  def validate!
    errors = []
    errors << 'Номер вагона не может быть пустым!' if num_vagon.empty?
    errors << 'Неверный тип вагона. Он может быть pass или cargo!' unless %w[
      pass cargo
    ].include?(type_vagon)
    errors << 'Имя производителя не может быть пустым!' if manufacturer.empty?
    return if errors.empty?

    raise errors.join("\n")
  end
end
