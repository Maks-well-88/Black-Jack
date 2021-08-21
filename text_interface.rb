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
    @dealer = Dealer.new
    @bank = GameBank.new
  end

  # a new deck of cards is created and the count of cards is reset
  def create_new_card_layout
    @deck = CardDesk.new
    @user_card_store = []
    @dealer_card_store = []
    user.points = 0
    dealer.points = 0
  end

  # starting the game, the first deal of cards, transferring the bet to the bank
  def start_of_the_game
    create_new_card_layout
    bank.place_a_bet(user, dealer)
    puts "Ставка: #{bank.bid}$. #{user.name}: #{user.bank}$, #{dealer.name}: #{dealer.bank}$."
    2.times { distribution_to_the_user }
    user_card_info
    2.times { distribution_to_the_dealer }
    dealer_card_info
    user_next_action
  end

  # player next actions menu
  def user_next_action
    actions = [
      { action_title: "\nПропустить свой ход", index: 1, action: :skip_turn },
      { action_title: 'Добавить себе карту', index: 2, action: :add_card_to_user },
      { action_title: 'Открыть карты у всех', index: 3, action: :show_all_cards }
    ]
    loop do
      actions.each do |action|
        puts "#{action[:action_title]} - (#{action[:index]})"
      end
      print 'Выберите действие: '
      choice = gets.chomp.to_i
      action = actions.detect { |i| i[:index] == choice }
      send(action[:action])
    end
  end

  # add another card to the player
  def add_card_to_user
    counting_results if user_card_store.size == 3 && dealer_card_store.size == 3
    distribution_to_the_user unless user_card_store.size == 3
    user_card_info
    skip_turn
  end

  #skip the turn in favor of the dealer
  def skip_turn
    counting_results if user_card_store.size == 3 && dealer_card_store.size == 3
    dealer.points < 17 ? distribution_to_the_dealer : nil
    dealer_card_info
    user_next_action
  end

  # show the player's and dealer's cards to summarize the game
  def show_all_cards
    system 'clear'
    print "#{user.name}: "
    user_card_store.each { |card| print "[#{card}] " }
    puts "Очков: #{user.points}"
    print "#{dealer.name}: "
    dealer_card_store.each { |card| print "[#{card}] " }
    puts "Очков: #{dealer.points}"
    counting_results
  end

  # функция подсчета результатов игры
  def counting_results
    if user.points > dealer.points && user.points <= 21
      puts "Победа за #{user.name}! #{dealer.name} проиграл."
      bank.transfer_of_the_amount_to_the_winner(user)
      puts "#{user.name}: #{user.bank}$, #{dealer.name}: #{dealer.bank}$."
    elsif dealer.points > user.points && dealer.points <= 21
      dealer_card_store.each { |card| print "[#{card}] " }
      puts "Победа за #{dealer.name}, #{user.name} проиграл!"
      bank.transfer_of_the_amount_to_the_winner(dealer)
      puts "#{user.name}: #{user.bank}$, #{dealer.name}: #{dealer.bank}$."
    elsif user.points > 21
      dealer_card_store.each { |card| print "[#{card}] " }
      puts "Победа за #{dealer.name}, #{user.name} проиграл!"
      bank.transfer_of_the_amount_to_the_winner(dealer)
      puts "#{user.name}: #{user.bank}$, #{dealer.name}: #{dealer.bank}$."
    elsif dealer.points > 21
      "Победа за #{user.name}! #{dealer.name} проиграл."
      bank.transfer_of_the_amount_to_the_winner(user)
      puts "#{user.name}: #{user.bank}$, #{dealer.name}: #{dealer.bank}$."
    else
      puts "В этом раунде ничья!"
      bank.refunds_to_players(user, dealer)
      puts "#{user.name}: #{user.bank}$, #{dealer.name}: #{dealer.bank}$."
    end
    continue_the_game
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

  #the function continues or ends the game
  def continue_the_game
      print 'Завершить? (y/n): '
      choice = gets.chomp
      system 'clear'
      choice == 'y' ? abort : start_of_the_game
  end
end
