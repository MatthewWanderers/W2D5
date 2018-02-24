class MaxIntSet

  def initialize(max)
    @max = max
    @store = Array.new(max)
  end

  def insert(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num] = true

  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num < @max && num >= 0
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    bucket = num % num_buckets
    @store[bucket] << num unless include?(num)
  end

  def remove(num)
    @store.each do |el|
      el.delete(num) if el.include?(num)
    end
  end

  def include?(num)
    @store.each do |el|
      return true if el.first == num
    end
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
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

    resize! if num_buckets == @count

    bucket = num % num_buckets

    unless include?(num)
      @count += 1
      @store[bucket] << num
    end

    # @store[bucket] << num unless include?(num)

  end

  def remove(num)
    if include?(num)
      @count -= 1
      @store.each do |el|
        el.delete(num) if el.include?(num)
      end
    end
  end

  def include?(num)
    @store.each do |el|
      return true if el.first == num
    end
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    @store += Array.new(num_buckets) { Array.new }
  end
end
