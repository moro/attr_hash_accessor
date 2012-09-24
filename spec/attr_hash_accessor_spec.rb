require 'spec_helper'
require 'attr_hash_accessor'

describe AttrHashAccessor do
  let(:my_klass) do
    Class.new do
      include AttrHashAccessor

      attr_hash_reader :foo
      attr_hash_writer :foo
    end
  end

  describe 'Basic usage' do
    subject(:object) { my_klass.new(foo: 'bar') }

    its(:foo) { should == 'bar' }

    context 'writer' do
      before do
        object.foo = 'FOOO'
      end
      its(:foo) { should == 'FOOO' }
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
end
