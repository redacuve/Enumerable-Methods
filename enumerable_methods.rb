module Enumerable
  def my_each
    if block_given?
      i = 0
      while i < length
        yield(self[i])
        i += 1
      end
    else
      to_enum(:my_each)
    end
  end

  def my_each_with_index
    if block_given?
      i = 0
      while i < length
        yield(self[i], i)
        i += 1
      end
    else
      to_enum(:my_each_with_index)
    end
  end

  def my_select
    ary = []
    if block_given?
      my_each { |elem| ary.push(elem) if yield(elem) }
      ary
    else
      to_enum(:my_select)
    end
  end

  def my_all?(pattern = nil)
    if pattern.is_a? Regexp
      my_each { |elem| return false unless elem =~ pattern }
    elsif pattern
      my_each { |elem| return false unless elem.is_a? pattern }
    elsif block_given?
      my_each { |elem| return false unless yield(elem) }
    else
      my_each { |elem| return false unless elem }
    end
    true
  end

  def my_any?
    if block_given?
      my_each { |elem| return true if yield(elem) }
    else
      my_each { |elem| return true if elem }
    end
    false
  end

  def my_none?
    if block_given?
      my_each { |elem| return false if yield(elem) }
    else
      my_each { |elem| return false if elem }
    end
    true
  end

  def my_count
    c = 0
    if block_given?
      my_each { |elem| c += 1 if yield(elem) }
    else
      my_each { c += 1 }
    end
    c
  end

  def my_map(proc = nil)
    if proc
      ary = []
      my_each { |elem| ary.push(proc.call(elem)) }
      ary
    elsif block_given?
      ary = []
      my_each { |elem| ary.push(yield(elem)) }
      ary
    else
      to_enum(:my_map)
    end
  end

  def my_inject(cont = nil)
    if block_given?
      cont ||= 0
      my_each { |elem| cont = yield(cont, elem) }
      cont
    else
      'No block Given (LocalJumpError)'
    end
  end
end

def multiply_els(arr)
  arr.my_inject(1) { |product, element| product * element }
end
