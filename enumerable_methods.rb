module Enumerable
  def my_each
    if block_given?
      i = 0
      while i < self.length
        yield(self[i])
        i += 1
      end
    else
      'No block given'
    end
  end

  def my_each_with_index
    if block_given?
      i = 0
      while i < self.length
        yield(self[i], i)
        i += 1
      end
    else
      'No block given'
    end
  end

  def my_select
    ary = []
    if block_given?
      self.my_each { |elem| ary.push(elem) if yield(elem) }
    else
      'No block given'
    end
    ary
  end

  def my_all?
    if block_given?
      my_each { |elem| return false unless yield(elem) }
      return true
    else
      my_each { |elem| return false unless elem }
      return true
    end
  end

  def my_any?
    if block_given?
      my_each { |elem| return true if yield(elem) }
     return false
    else
      my_each { |elem| return true if elem }
      return false
    end
  end

  def my_none?
    if block_given?
      my_each { |elem| return false if yield(elem) }
      return true
    else
      my_each { |elem| return false if elem }
      return true
    end
  end

  def my_count
    if block_given?
      c = 0
      my_each { |elem| c += 1 if yield(elem) }
      return c
    else
      c = 0
      my_each { |elem| c += 1 }
      return c
    end
  end

  def my_map(proc = nil)
    if proc
      ary = []
      my_each { |elem| ary.push(proc.call(elem)) }
      return ary
    elsif block_given?
      ary = []
      my_each { |elem| ary.push(yield(elem)) }
      return ary
    else
      return to_enum(:my_map)
    end
  end

  def my_inject(param = nil)
    if block_given?
      if param
        c = param
      else
        c = 0
      end
      my_each { |elem| c = yield(c, elem) }
      c
    else
      'No block Given (LocalJumpError)'
    end
  end
end

def multiply_els(arr)
  arr.my_inject(1) { |product, element| product * element }
end

puts multiply_els([2,4,5])