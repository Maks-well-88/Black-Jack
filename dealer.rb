# frozen_string_literal: true

require_relative './modules/actions'
require_relative 'deck'

class Dealer
  include Actions
  attr_accessor :bank, :two_cards, :points, :scored_points

  def initialize
    @points = 0
    @bank = 100
  end

  def deal_of_two_cards(deck)
    @two_cards = deck.cards.keys.sample(2)
    count_points(deck)
    deck.cards.delete(@two_cards[0])
    deck.cards.delete(@two_cards[1])
  end

  def count_points(deck)
    @scored_points = deck.cards[@two_cards[0]] + deck.cards[@two_cards[1]]
  end



end
