# frozen_string_literal: true

require_relative './modules/actions'

class User
  include Actions
  attr_accessor :bank, :points
  attr_reader :name

  def initialize(name)
    @name = name
    @points = 0
    @bank = 100
  end
end
