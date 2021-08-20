# frozen_string_literal: true

require_relative './modules/actions'

class Dealer
  include Actions
  attr_accessor :bank, :one_card, :points, :scored_points

  def initialize
    @points = 0
    @bank = 100
  end

  def give_card(deck, person)
    @one_card = deck.cards.keys.sample
    count_points(deck, person)
    deck.cards.delete(@one_card)
    return @one_card
  end

  private
  
  def count_points(deck, person)
    if deck.cards[@one_card].is_a?(Array) && person.points <= 10
      @scored_points = deck.cards[@one_card][1]
    elsif deck.cards[@one_card].is_a?(Array) && person.points > 10
      @scored_points = deck.cards[@one_card][0]
    else
      @scored_points = deck.cards[@one_card]
    end
  end
end
