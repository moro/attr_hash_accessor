# AttrHashAccessor

AttrHashAccessor provides Hash based attribute accessor macro.

## Installation

Add this line to your application's Gemfile:

    gem 'attr_hash_accessor'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install attr_hash_accessor

## Usage

### Basic usage

```
class MyClass
  include AttrHashAccessor

  attr_hash_writer :bar
  attr_hash_reader :foo, :bar
  attr_hash_accessor :baz
end

obj = MyClass.new(foo: 'FOO', bar: 'BAR', baz: 'BAZ')
obj.foo # => 'FOO'

obj.bar = 'BARBAR'
obj.bar # => 'BARBAR'

obj.baz # => 'BAZ'
obj.baz = 'BAZBAZ'
obj.baz # => 'BAZBAZ'
```

### Getter with filter

```
class MyClass
  include AttrHashAccessor

  attr_hash_writer :foo
  attr_hash_reader :foo, &->(val) { Array(val) }
  attr_hash_accessor :bar, &->(val) { val || {} }
end

obj = MyClass.new
obj.foo # => []
obj.bar  # => {}

obj.foo = [1, 2, 3]
obj.foo # => [1, 2, 3]

obj.bar = {lorem: 'ipsum'}
obj.bar # => {:lorem=>"ipsum"}
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
