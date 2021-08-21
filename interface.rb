# frozen_string_literal: true

require_relative 'deck'
require_relative 'dealer'
require_relative 'bank'
require_relative 'user'

# class creates an interface for user interaction with the game
class Interface
  attr_reader :dealer, :deck, :user
  attr_accessor :user_combination, :dealer_combination, :bank

  def initialize(name)
    @user = User.new(name)
    @dealer = Dealer.new
    @bank = GameBank.new
  end

  # starting the round, the first deal of cards, transferring the bet to the bank
  def round_start
    create_new_card_layout
    bank.place_a_bet
    print "Ставка: #{bank.bid}$. "
    show_players_money
    2.times { distribution_to_the_user }
    user_card_info
    2.times { distribution_to_the_dealer }
    dealer_card_info
    user_next_action
  end

  # player next actions menu
  def user_next_action
    puts "\nПропустить свой ход - (1)"
    puts 'Добавить себе карту - (2)'
    puts 'Открыть все карты - (3)'
    option = gets.chomp.to_i
    case option
    when 1 then skip_turn
    when 2 then add_card_to_user
    when 3 then complete_round
    end
  end

  # add another card to the player
  def add_card_to_user
    distribution_to_the_user unless user_combination.size == 3
    dealer_combination.size == 3 ? complete_round : skip_turn
  end

  # skip the turn in favor of the dealer
  def skip_turn
    dealer.points < 17 ? distribution_to_the_dealer : nil
    user_card_info && dealer_card_info if dealer_combination.size != 3 && user_combination.size != 3
    dealer_combination.size == 3 && user_combination.size == 3 ? complete_round : user_next_action
  end

  # sums up the game, reveals the cards, announces the winners
  def complete_round
    open_all_cards
    counting_results
    show_players_money
    continue_the_game
  end

  private

  # a new deck of cards is created and the count of cards is reset
  def create_new_card_layout
    @deck = CardDesk.new
    @user_combination = []
    @dealer_combination = []
    user.points = 0
    dealer.points = 0
  end

  # function of calculating the results of the game
  def counting_results
    if (dealer.points > 21 && user.points > 21) || (dealer.points == user.points)
      bank.refunds_to_players
      puts 'В этом раунде ничья!'
    elsif user.points > dealer.points && user.points <= 21 || dealer.points > 21
      bank.money_for_the_winner('user')
      puts "#{user.name}, вы выиграли!"
    elsif dealer.points > user.points && dealer.points <= 21 || user.points > 21
      bank.money_for_the_winner('dealer')
      puts "#{dealer.name}, вы выиграли!"
    end
  end

  # shows the status of players' accounts
  def show_players_money
    puts "#{user.name}: #{bank.user_money}$, #{dealer.name}: #{bank.dealer_money}$."
  end

  # withdraw the player's cards after the next move
  def user_card_info
    user_combination.each { |card| print "[#{card}] " }
    puts "Очков: #{user.points}"
  end

  # withdraw the dealer's cards after the next move
  def dealer_card_info
    dealer_combination.each { |_card| print '[* *] ' }
  end

  # show the player's and dealer's cards to summarize the game
  def open_all_cards
    print "#{user.name}: "
    user_combination.each { |card| print "[#{card}] " }
    puts "Очков: #{user.points}"
    print "#{dealer.name}: "
    dealer_combination.each { |card| print "[#{card}] " }
    puts "Очков: #{dealer.points}"
  end

  # dealing cards to the player and removing the dealt cards from the deck
  def distribution_to_the_user
    user_combination << dealer.give_card(deck, user)
    user.points += dealer.scored_points
  end

  # dealing cards to the dealer and removing the dealt cards from the deck
  def distribution_to_the_dealer
    dealer_combination << dealer.give_card(deck, dealer)
    dealer.points += dealer.scored_points
  end

  # the function continues or ends the game
  def continue_the_game
    print 'Завершить? (y/n): '
    choice = gets.chomp
    system 'clear'
    choice == 'y' ? abort : round_start
  end
end
