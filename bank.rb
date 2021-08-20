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
    puts "На кону #{self.bid} $."
  end
end
