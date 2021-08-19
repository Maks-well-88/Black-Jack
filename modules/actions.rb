# frozen_string_literal: true

module Actions
  def self.included(base)
    base.include InstanceMethods
    base.extend ClassMethods
  end

  module ClassMethods
  end

  module InstanceMethods

    def skip; end

    def add_card; end

    def open_cards; end
  end
end
