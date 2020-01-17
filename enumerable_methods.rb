# rubocop:disable Metrics/ModuleLength
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
# rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
  def my_all?(pattern = nil)
    if pattern
      if pattern.is_a? Regexp
        my_each { |elem| return false unless elem =~ pattern }
      elsif pattern.is_a? Class
        my_each { |elem| return false unless elem.is_a? pattern }
      else
        my_each { |elem| return false unless elem == pattern }
      end
    elsif block_given?
      my_each { |elem| return false unless yield(elem) }
    else
      my_each { |elem| return false unless elem }
    end
    true
  end
# rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def my_any?(pattern = nil)
    if pattern
      if pattern.is_a? Regexp
        my_each { |elem| return true if elem =~ pattern }
      elsif pattern
        my_each { |elem| return true if elem.is_a? pattern }
      else
        my_each { |elem| return true if elem == pattern }
      end
    elsif block_given?
      my_each { |elem| return true if yield(elem) }
    else
      my_each { |elem| return true if elem }
    end
    false
  end
# rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def my_none?(pattern = nil)
    if pattern
      if pattern.is_a? Regexp
        my_each { |elem| return false if elem =~ pattern }
      elsif pattern
        my_each { |elem| return false if elem.is_a? pattern }
      else
        my_each { |elem| return false if elem == pattern }
      end
    elsif block_given?
      my_each { |elem| return false if yield(elem) }
    else
      my_each { |elem| return false if elem }
    end
    true
  end

  def my_count(arg = nil)
    c = 0
    if arg
      my_each { |elem| c += 1 if elem == arg }
    elsif block_given?
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
# rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def my_inject(cont = nil, symb = nil)
    if (cont.is_a? Symbol) || (symb.is_a? Symbol)
      if cont.is_a? Symbol
        case cont
        when :+
          c = 0
          my_each { |elem| c += elem }
        when :-
          c = self[0]
          self[1..-1].my_each { |elem| c -= elem }
        when :*
          c = self[0]
          self[1..-1].my_each { |elem| c *= elem }
        when :/
          c = self[0]
          self[1..-1].my_each { |elem| c /= elem }
        end
        c
      elsif cont.is_a? Numeric
        case symb
        when :+
          my_each { |elem| cont += elem }
        when :-
          my_each { |elem| cont -= elem }
        when :*
          my_each { |elem| cont *= elem }
        when :/
          my_each { |elem| cont /= elem }
        end
        cont
      else
        "undefined method for #{cont}:#{cont.class}"
      end
    elsif block_given?
      cont ||= 0
      my_each { |elem| cont = yield(cont, elem) }
      cont
    else
      'no block given (LocalJumpError)'
    end
  end
end

def multiply_els(arr)
  arr.my_inject(1) { |product, element| product * element }
end
# rubocop:enable Metrics/ModuleLength
