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
end

obj = MyClass.new(foo: 'FOO', bar: 'BAR')
obj.foo #=> 'FOO'

obj.bar = 'BARBAR'
obj.bar # => 'BARBAR'
```

### Getter with filter

```
class MyClass
  include AttrHashAccessor

  attr_hash_writer :vars
  attr_hash_reader :vars, ->(val) { Array(val) }
end

obj = MyClass.new
obj.vars # => []

obj.vars = [1, 2, 3]
obj.vars #=> [1, 2, 3]
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
