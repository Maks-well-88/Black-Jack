# frozen_string_literal: true

# class creates a player named
class User
  attr_accessor :points, :money
  attr_reader :name

  def initialize(name)
    @name = name
    @points = 0
    @money = 100
  end
end
