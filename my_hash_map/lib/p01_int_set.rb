class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
    @max = max
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num.between?(0,@max)
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }

  end

  def insert(num)
    @store[(num % num_buckets).abs] << num
  end

  def remove(num)
    @store[(num % num_buckets).abs].delete(num)
  end

  def include?(num)
    @store[(num % num_buckets).abs].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if include?(num)
      false
    else
      @count += 1
      resize! if @count == num_buckets
      @store[(num % num_buckets).abs] << num
      true
    end

  end

  def remove(num)
    @store[(num % num_buckets).abs].delete(num)
    @count -= 1
  end

  def include?(num)
    @store[(num % num_buckets).abs].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { Array.new }
    @store.each do |buck|
      buck.each do |set_element|
        new_store[set_element % new_store.length] << set_element
      end
    end
    @store = new_store
  end

end
