require 'spec_helper'
require 'attr_hash_accessor'

describe AttrHashAccessor do
  let(:my_klass) do
    Class.new do
      include AttrHashAccessor

      attr_hash_reader :foo
      attr_hash_writer :foo
      attr_hash_accessor :bar
    end
  end

  describe 'Basic usage' do
    subject(:object) { my_klass.new(foo: 'bar', bar: 'baz') }

    its(:foo) { should == 'bar' }
    its(:bar) { should == 'baz' }

    context 'writer / reader' do
      before do
        object.foo = 'FOOO'
      end

      its(:foo) { should == 'FOOO' }
    end

    context 'accessor' do
      before do
        object.bar = 'BARRR'
      end

      its(:bar) { should == 'BARRR' }
    end
  end

  describe 'empty initialize' do
    specify do
      expect { my_klass.new }.not_to raise_exception
    end

    specify do
      expect { my_klass.new(nil) }.not_to raise_exception
    end
  end

  describe 'filter attribute' do
    let(:my_klass2) do
      Class.new do
        include AttrHashAccessor
        attr_hash_reader :arr, &->(v) { v.presence || [1] }
      end
    end
    subject(:object) { my_klass2.new(nil) }
    its(:arr) { should == [1] }
  end
end
