# frozen_string_literal: true

# the class creates a bank for game bets: it accepts money in the bet and distributes the winnings
class Bank
  attr_accessor :bid

  def initialize
    @bid = 20
  end

  def place_a_bet(*persons)
    persons.each do |person|
      current_amount = person.instance_variable_get :@money
      current_amount -= self.bid / 2
      person.instance_variable_set :@money, current_amount
    end
  end

  def refunds_to_players(*persons)
    persons.each do |person|
      current_amount = person.instance_variable_get :@money
      current_amount += self.bid / 2
      person.instance_variable_set :@money, current_amount
    end
  end

  def money_for_the_winner(winner)
    current_amount = winner.instance_variable_get :@money
    current_amount += self.bid
    winner.instance_variable_set :@money, current_amount
  end
end
