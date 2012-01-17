class Cart < ActiveRecord::Base
  attr_reader :items

  def initialize
    @items = []
  end

  def add_test(test)
    @items << test
  end

end
