# frozen_string_literal: true

require_relative '../modules/actions'

class Dealer
  include Actions
  attr_accessor :bank

  def initialize
    @bank = 100
  end
end
