# frozen_string_literal: true

require_relative './modules/actions'
require_relative 'deck'
require_relative 'dealer'
require_relative 'bank'
require_relative 'user'

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

  # starting the game, the first deal of cards, transferring the bet to the bank
  def start_of_the_game
    puts "#{user.name}, ваши карты:"
    2.times { distribution_to_the_user }
    user_card_info
    puts 'Карты дилера:'
    2.times { distribution_to_the_dealer }
    dealer_card_info
    bank.place_a_bet(user, dealer)
    user_next_action
  end

  # player next actions menu
  def user_next_action
    message = [
      { action_title: "\nПропустить ход", index: 1, action: :skip_turn },
      { action_title: 'Добавить себе карту', index: 2, action: :add_card_to_user },
      { action_title: 'Открыть карты', index: 3, action: :show_all_cards }
    ]
    loop do
      message.each do |message|
        puts "#{message[:action_title]} - (#{message[:index]})"
      end
      print 'Выберите действие: '
      choice = gets.chomp.to_i
      action = message.detect { |i| i[:index] == choice }
      send(action[:action])
    end
  end

  #skip the turn in favor of the dealer
  def skip_turn
    distribution_to_the_dealer
    dealer_card_info
  end

  # add another card to the player
  def add_card_to_user
    distribution_to_the_user
    user_card_info
  end

  # show the player's and dealer's cards to summarize the game
  def show_all_cards
    puts ''
    print "#{user.name}: "
    user_card_store.each { |card| print "[#{card}] " }
    puts "Очков: #{user.points}"
    print "#{dealer.name}: "
    dealer_card_store.each { |card| print "[#{card}] " }
    puts "Очков: #{dealer.points}"
    counting_results
  end

  # withdraw the player's cards after the next move
  def user_card_info
    user_card_store.each { |card| print "[#{card}] " }
    puts "Очков: #{user.points}"
  end

  # withdraw the dealer's cards after the next move
  def dealer_card_info
    dealer_card_store.each { |_card| print '[* *] ' }
  end

  # функция подсчета результатов игры
  def counting_results
    if user.points > dealer.points && user.points <= 21
      puts "Победа за #{user.name}! #{dealer.name} проиграл."
      bank.transfer_of_the_amount_to_the_winner(user)
    elsif dealer.points > user.points && dealer.points <= 21
      puts "Победа за #{dealer.name}, #{user.name} проиграл!"
      bank.transfer_of_the_amount_to_the_winner(dealer)
    elsif user.points > 21
      puts "Победа за #{dealer.name}, #{user.name} проиграл!"
      bank.transfer_of_the_amount_to_the_winner(dealer)
    elsif dealer.points > 21
      "Победа за #{user.name}! #{dealer.name} проиграл."
      bank.transfer_of_the_amount_to_the_winner(user)
    end
  end

  # dealing cards to the player and removing the dealt cards from the deck
  def distribution_to_the_user
    user_card_store << dealer.give_card(deck, user)
    user.points += dealer.scored_points
  end

  # dealing cards to the dealer and removing the dealt cards from the deck
  def distribution_to_the_dealer
    dealer_card_store << dealer.give_card(deck, dealer)
    dealer.points += dealer.scored_points
  end
end
