# frozen_string_literal: true

# the class creates a deck of 52 cards
class Deck
  attr_accessor :cards

  def initialize
    @cards = {}
    cards_generator
  end

  def cards_generator
    suits = ['♠', '♣', '♥', '♦']
    ranks = {
      '2': 2, '3': 3, '4': 4, '5': 5, '6': 6, '7': 7, '8': 8,
      '9': 9, '10': 10, 'В': 10, 'Д': 10, 'К': 10, 'Т': [1, 11]
    }
    suits.each do |suit|
      ranks.each do |card, points|
        @cards["#{card} #{suit}"] = points
      end
    end
  end
end
