# frozen_string_literal: true

require_relative 'user'

# class creates a dealer who deals cards and counts points
class Dealer < User
  attr_accessor :card, :scored_points

  def initialize(name = 'Петрович')
    super
  end

  # issues a card from the deck 1 at a time
  def give_card(deck, person)
    self.card = deck.cards.keys.sample
    self.scored_points = count_points(deck, person)
    deck.cards.delete(card)

    card
  end

  private

  # counts card points after each deal
  def count_points(deck, person)
    if deck.cards[card].is_a?(Array)
      person.points <= 10 ? deck.cards[card][1] : deck.cards[card][0]
    else
      deck.cards[card]
    end
  end
end
