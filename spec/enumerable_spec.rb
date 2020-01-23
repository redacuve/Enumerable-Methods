require_relative '../enumerable_methods.rb'

describe Enumerable do
  describe '#my_each' do
    it 'Display every number given on the array' do
      expect { |args| [1, 2, 3, 4, 5].my_each(&args) }.to yield_successive_args(1, 2, 3, 4, 5)
    end

    it 'Display an Enumerator if block is not given' do
      expect([1, 2, 3, 4, 5].my_each.class).to eql(Enumerator)
    end
  end

  describe '#my_each' do
    it 'Display every number given on the array' do
      expect { |args| [1, 2, 3, 4, 5].my_each(&args) }.to yield_successive_args(1, 2, 3, 4, 5)
    end
  end

  describe '#my_map' do
    it 'Display every number given on the array' do
      expect([1, 2, 3, 4, 5].my_map { |elem| elem * 2 }).to eql([2, 4, 6, 8, 10])
    end
  end
end
