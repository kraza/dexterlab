class Array
  
  def to_hash_keys(&block)
    Hash[*self.collect { |v|
      [v, block.call(v)]
    }.flatten]
  end

  def to_hash_values(&block)
    Hash[*self.collect { |v|
      [block.call(v), v]
    }.flatten]
  end

  def to_h
    arr = self.dup
    if arr.size % 2 == 0
        Hash[*arr]
    else
        Hash[*arr << nil]
    end
  end
  
end