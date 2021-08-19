# frozen_string_literal: true

require_relative 'text_interface'

print 'Напишите, как вас зовут: '
interface = Interface.new(gets.chomp.capitalize)
interface.run
