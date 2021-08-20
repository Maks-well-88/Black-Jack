# frozen_string_literal: true

class GameBank
  attr_accessor :bid

  def initialize
    @bid = 0
  end

  def place_a_bet(user, dealer)
    self.bid += 20
    user.bank -= 10
    dealer.bank -= 10
    puts "\nНа кону #{self.bid} $."
  end

  def transfer_of_the_amount_to_the_winner(winner)
    self.bid = 0
    winner.bank += 20
    puts "На счету #{winner.name} - #{winner.bank} $."
  end
end
