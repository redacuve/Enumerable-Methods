require_relative '../enumerable_methods.rb'

describe Enumerable do
  let(:test_array) { [2, 2, 2, 4, 8] }
  describe '#my_each' do
    it 'Display every number given on the array' do
      expect { |args| [1, 2, 3, 4, 5].my_each(&args) }.to yield_successive_args(1, 2, 3, 4, 5)
    end

    it 'It takes and array return each element' do
      num_arr = [1, 2, 3, 4, 5]
      elem_str = ''
      num_arr.my_each { |elem| elem_str += elem.to_s }
      expect(elem_str).to eq('12345')
    end

    it 'Display an Enumerator if block is not given' do
      expect([1, 2, 3, 4, 5].my_each.class).to eql(Enumerator)
    end
  end

  describe '#my_each_with_index' do
    it 'It takes and array and add every index to an string' do
      num_arr = [1, 2, 3, 4, 5]
      i_str = ''
      num_arr.my_each_with_index { |_elem, i| i_str += i.to_s }
      expect(i_str).to eq('01234')
    end

    it 'Display an Enumerator if block is not given' do
      expect([1, 2, 3, 4, 5].my_each_with_index.class).to eql(Enumerator)
    end
  end

  describe '#my_select' do
    it 'Only return if a number is multiple of 3' do
      expect([1, 2, 3, 4, 5, 6, 7, 8, 9, 10].my_select { |i| i % 3 == 0 }).to eql([3, 6, 9])
    end

    it 'Return only if a number is even' do
      expect([1, 2, 3, 4, 5].my_select(&:even?)).to eql([2, 4])
    end

    it 'Display an Enumerator if block is not given' do
      expect([1, 2, 3, 4, 5].my_select.class).to eql(Enumerator)
    end
  end

  describe '#my_all?' do
    it 'Display true if the collection of the array is only Numeric' do
      expect([1, 2i, 3.14].my_all?(Numeric)).to eql(true)
    end

    it 'Display false if the collection on the array contains an falsy value' do
      expect([nil, true, 99].my_all?).to eql(false)
    end

    it 'Display true if block is not given' do
      expect([1, 2, 3, 4, 5].my_all?).to eql(true)
    end
  end

  describe '#my_any?' do
    it 'Display true if any the collection of the array is Numeric' do
      expect([1, 2i, 3.14].my_any?(Numeric)).to eql(true)
    end

    it 'Display true if the collection on the array contains an falsy value and at least one true value' do
      expect([nil, true, 99].my_all?).to eql(false)
    end

    it 'Display true if block is not given' do
      expect([1, 2, 3, 4, 5].my_all?).to eql(true)
    end
  end

  describe '#my_none?' do
    it 'Display false if the collection of the array is only Numeric' do
      expect([1, 2i, 3.14].my_none?(Numeric)).to eql(false)
    end

    it 'Display false if the collection on the array contains an falsy value' do
      expect([nil, true, 99].my_none?).to eql(false)
    end

    it 'Display false if block is not given' do
      expect([1, 2, 3, 4, 5].my_none?).to eql(false)
    end
  end

  describe '#my_count' do
    it 'Display the count of the array is no block is given' do
      expect([1, 2, 4, 2].my_count).to eql(4)
    end

    it 'Display the count only if a value is even' do
      expect([1, 2, 4, 2].my_count(&:even?)).to eql(3)
    end

    it 'Count only the values on the array that are 2' do
      expect([1, 2, 4, 2].my_count(2)).to eql(2)
    end
  end

  describe '#my_map' do
    it 'Display every number given on the array multiplied by 2' do
      expect([1, 2, 3, 4, 5].my_map { |elem| elem * 2 }).to eql([2, 4, 6, 8, 10])
    end

    it 'Cange every value on the array to a string' do
      expect([1, 2, 3, 4, 5].my_map(&:to_s)).to eql(%w[1 2 3 4 5])
    end

    it 'Display an enumerator is block is not given' do
      expect([1, 2, 3, 4, 5].my_map.class).to eql(Enumerator)
    end
  end

  describe '#my_inject' do
    it 'Sum all the values in the array given an symbol' do
      expect([1, 2, 3, 4, 5, 6, 7, 8, 9, 10].my_inject(:+)).to eql(55)
    end

    it 'Sum all the values in the array with a block' do
      expect([1, 2, 3, 4, 5, 6, 7, 8, 9, 10].my_inject { |sum, n| sum + n }).to eql(55)
    end

    it 'Display local jum error, if no parameters and no block given' do
      expect([1, 2, 3, 4, 5, 6, 7, 8, 9, 10].my_inject).to eql('no block given (LocalJumpError)')
    end
  end
end
