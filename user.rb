# frozen_string_literal: true

require_relative '../modules/actions'

class User
  include Actions
  attr_accessor :bank
  attr_reader :name

  def initialize(name)
    @name = name
    @bank = 100
  end
end
