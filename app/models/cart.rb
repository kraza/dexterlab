class Cart 
  attr_reader :items

  def initialize
    @items = []
    @test_ids = []
  end

  def add_test(test)
    test.s_no = @items.count.to_i+1
    @items << test
    @test_ids << test.id
  end

  #clear deleted item from items array.
  def clear_items product_id
    items.delete_if{|item| item.id.to_i == product_id.to_i }
    test_ids.delete_if{|test_id| test_id.to_i == product_id.to_i}
    
    items.map{ |ob| (ob.s_no -= 1) if ob.s_no.to_i > product_id.to_i }
  end

end
