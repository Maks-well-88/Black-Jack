# frozen_string_literal: true

require_relative 'text_interface'
require_relative 'card_desk'
require_relative 'diller'
require_relative 'game_bank'
require_relative 'user'

print 'Напишите, как вас зовут: '
user = User.new(gets.chomp.capitalize!)
interface = Interface.new
diller = Diller.new
game_bank = GameBank.new
card_desk = CardDesk.new
interface.run
