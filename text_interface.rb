# frozen_string_literal: true

require_relative './modules/actions.rb'
require_relative 'deck.rb'
require_relative 'dealer.rb'
require_relative 'bank.rb'
require_relative 'user.rb'

class Interface
  include Actions
  attr_reader :dealer, :deck, :user
  attr_accessor :user_card_store, :dealer_card_store, :bank

  def initialize(name)
    @user = User.new(name)
    @deck = CardDesk.new
    @dealer = Dealer.new
    @bank = GameBank.new
    @user_card_store = []
    @dealer_card_store = []
  end

  def start_of_the_game
    puts "#{user.name}, ваши карты:"
    distribution_to_the_user
    puts 'Карты дилера:'
    distribution_to_the_dealer
    bank.place_a_bet(user, dealer)
  end

  def distribution_to_the_user
    user_card_store << dealer.give_card(deck, user)
    user.points += dealer.scored_points
    user_card_store << dealer.give_card(deck, user)
    user.points += dealer.scored_points
    puts "[#{user_card_store[0]}] & [#{user_card_store[1]}], очков: #{user.points}."
  end

  def distribution_to_the_dealer
    dealer_card_store << dealer.give_card(deck, dealer)
    dealer.points += dealer.scored_points
    dealer_card_store << dealer.give_card(deck, dealer)
    dealer.points += dealer.scored_points
    puts '[**] & [**]'
    puts "У диллера реально #{dealer.points} очков."
  end



end
