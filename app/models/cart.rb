class Cart
  attr_reader :items, :test_ids

  # test_ids is add to show/ remove tests in drop down  as per test selection.
  # if test is aaded then remove test fromdrop down and if test removed from patient
  # basket then again add test to drop.
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
  def reset_cart test_id, s_no
    items.delete_if{|obj| obj.id.to_i == test_id.to_i }
    test_ids.delete_if{|test| test.to_i == test_id.to_i}

    items.map{ |ob| (ob.s_no -= 1) if ob.s_no.to_i > s_no.to_i }
  end

end
