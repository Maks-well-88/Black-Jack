# frozen_string_literal: true

require_relative './classes/interface.rb'

puts 'Привет! Я - Петрович. Сегодня я буду дилером в нашей игре!'
print 'А как тебя зовут? '
interface = Interface.new(gets.chomp.capitalize)
system 'clear'
interface.round_start
