# frozen_string_literal: true

# the class creates a bank for game bets: it accepts money in the bet and distributes the winnings
class Bank
  attr_accessor :bid

  def initialize
    @bid = 0
  end

  def place_a_bet(*persons)
    self.bid = 20
    persons.each do |person|
      current_amount = person.instance_variable_get :@money
      current_amount -= self.bid
      person.instance_variable_set :@money, current_amount
    end
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
