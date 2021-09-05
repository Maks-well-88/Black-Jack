# frozen_string_literal: true

# the class creates a bank for game bets: it accepts money in the bet and distributes the winnings
class Bank
  attr_accessor :bid

  def initialize
    @bid = 20
  end

  def place_a_bet(*persons)
    persons.each do |person|
      money_counting(person)
      person.instance_variable_set :@money, @reduced_money
    end
  end

  def refunds_to_players(*persons)
    persons.each do |person|
      money_counting(person)
      person.instance_variable_set :@money, @increased_money
    end
  end

  def money_for_the_winner(person)
    money_counting(person)
    person.instance_variable_set :@money, @gain
  end

  private

  def money_counting(person)
    current_amount = person.instance_variable_get :@money
    @reduced_money = current_amount - (bid / 2)
    @increased_money = current_amount + (bid / 2)
    @gain = current_amount + bid
  end
end
