# frozen_string_literal: true

require_relative 'text_interface'

puts "Привет! Я - Петрович. Сегодня я буду дилером в нашей игре!"
print 'А как тебя зовут? '
interface = Interface.new(gets.chomp.capitalize)
system 'clear'
interface.start_of_the_game
