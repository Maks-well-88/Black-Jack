# frozen_string_literal: true

require_relative './modules/actions'
require_relative 'deck'
require_relative 'dealer'
require_relative 'bank'
require_relative 'user'

class Interface
  include Actions
  attr_reader :dealer, :deck, :bank, :user

  user_card_store = []
  dealer_card_store = []

  def initialize(name)
    @user = User.new(name)
    @deck = CardDesk.new
    @dealer = Dealer.new
    @bank = GameBank.new
  end

  def run
    loop do
      puts "#{user.name}, ваши карты:"
      dealer.deal_of_two_cards(deck)
      user.points = dealer.scored_points
      puts "[#{dealer.two_cards[0]}] & [#{dealer.two_cards[1]}], #{dealer.scored_points} очков."
      puts 'Карты дилера:'
      dealer.deal_of_two_cards(deck)
      puts '[**] & [**]'
      dealer.points = dealer.scored_points
      puts "У диллера реально #{dealer.points} очков"
      print 'Хотите завершить игру? '
      x = gets.chomp.to_i
      break if x == 1
    end
  end

  def counting_results; end
end
