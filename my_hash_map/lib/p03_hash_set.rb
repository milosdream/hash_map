require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if include?(key)
      false
    else
      @count += 1
      resize! if @count == num_buckets
      @store[key.hash % num_buckets] << key.hash
      true
    end
  end

  def include?(key)
    @store[(key.hash % num_buckets).abs].include?(key.hash)
  end

  def remove(key)
    @store[key.hash % num_buckets].delete(key.hash)
    @count -= 1
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num]
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
