# frozen_string_literal: true

# the class creates a bank for game bets: it accepts money in the bet and distributes the winnings
class Bank
  attr_accessor :bid, :user_money, :dealer_money

  def initialize
    @bid = 0
    @user_money = 100
    @dealer_money = 100
  end

  def place_a_bet
    self.bid += 20
    self.user_money -= 10
    self.dealer_money -= 10
  end

  def refunds_to_players
    self.bid = 0
    self.user_money += 10
    self.dealer_money += 10
  end

  def money_for_the_winner(winner)
    self.bid = 0
    num = send("#{winner}_money".to_sym)
    num += 20
    instance_variable_set "@#{winner}_money".to_sym, num
  end
end
