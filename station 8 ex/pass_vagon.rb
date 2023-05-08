require_relative 'vagon'

class PassengerVagon < Vagon

  attr_accessor :occupied_seats, :seats

  def initialize(num_vagon, type_vagon, manufacturer, seats)
    super(num_vagon, "pass", manufacturer)
    @seats = seats
    @occupied_seats = 0
  end

  def occupy_seat
    if @occupied_seats < @seats
      @occupied_seats += 1
      puts "Место занято. Осталось #{@seats - @occupied_seats} свободных мест"
    else
      puts "Все места заняты"
    end
  end
    
  def free_seats
    @seats - @occupied_seats
  end
end