# frozen_string_literal: true

require_relative 'main'

main = Main.new

loop do
  puts 'Выберите действие:'
  puts '1 - Создать станцию'
  puts '2 - Создать поезд'
  puts '3 - Создать маршрут'
  puts '4 - Управление маршрутом'
  puts '5 - Назначить маршрут поезду'
  puts '6 - Добавить вагон к поезду'
  puts '7 - Отцепить вагон от поезда'
  puts '8 - Переместить поезд по маршруту'
  puts '9 - Просмотреть список станций'
  puts '10 - Просмотреть список поездов на станции'
  puts '11 - Просмотреть список всех станций и всех поездов на этих станциях'
  puts '12 - Занять место или объем в вагоне'
  puts '0 - Выход'
  choice = gets.chomp.to_i

  case choice
  when 1
    main.create_station
  when 2
    main.create_train
  when 3
    main.create_route
  when 4
    main.control_route
  when 5
    main.appoint_route
  when 6
    main.attach_vagon
  when 7
    main.unhook_vagon
  when 8
    main.moving_train
  when 9
    main.list_stations
  when 10
    main.list_trains_on_stations
  when 11
    main.each_stations
  when 12
    main.refueling_the_vagon
  when 0
    break
  else
    puts 'Неверный выбор'
  end
end
