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
  end

  def transfer_of_the_amount_to_the_winner(winner)
    self.bid = 0
    winner.bank += 20
  end

  def refunds_to_players(user, dealer)
    self.bid = 0
    user.bank += 10
    dealer.bank += 10
  end
end
