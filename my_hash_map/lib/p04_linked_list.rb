class Link
  attr_accessor :key, :val, :next

  def initialize(key = nil, val = nil, nxt = nil)
    @key, @val, @next = key, val, nxt
  end

  def to_s
    "#{@key}, #{@val}"
  end
end

class LinkedList
  include Enumerable

  attr_reader :head

  def initialize
    @head = Link.new
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    empty? ? nil : @head
  end

  def last
    return nil if empty?
    link = @head
    until link.next.val == nil
      link = link.next
    end
    link
  end

  def empty?
    @head.key == nil
  end

  def get(key)
    return nil if empty?
    link = @head
    until link.key == key
      return nil if link == last
      link = link.next
    end
    link.val
  end

  def include?(key)
    return false if empty?
    link = @head
    until link.key == key
      return false if link == last
      link = link.next
    end
    true
  end

  def insert(key, val)
    temp = Link.new(key, val, @head)
    @head = temp
  end

  def remove(key)
    return nil if empty?
    link = @head
    until link.next.key == key
      return nil if link == last
      link = link.next
    end
    link.next = link.next.next
  end

  def each
    link = @head
    until link.key == nil
      yield(link)
      link = link.next
    end
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
