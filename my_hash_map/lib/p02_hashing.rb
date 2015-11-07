class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    return 17 if self.empty?

    hashes = self.map do |el|
        unless el.class == Fixnum
          el = el.hash
        else
          el
        end
      end

    size = self.length

    num_s = "17"
    hashes.each do |i|
      num_s += i.to_s
    end

    secret_number = num_s.to_i

    secret_number2 = hashes.inject(69) do |acc, num|
      acc = size * hashes.first + (23 * num * 2) + 3 * hashes.last + acc
    end

    secret_number2 = secret_number2.to_s[0...10].to_i

    num = (secret_number2.abs + (secret_number * secret_number2.abs) + size)
    num.to_s[0...10].to_i
  end



end

class String
  def hash
    array = self.chars.map(&:ord)
    array.hash
  end
end

class Hash
  def hash
    array = []

    self.each do |k, v|
      array << k.to_s.hash
      array << v.to_s.hash
    end

    array.sort.hash
  end
end
