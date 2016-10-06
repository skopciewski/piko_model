# PikoModel

[![Gem Version](https://badge.fury.io/rb/piko_model.svg)](http://badge.fury.io/rb/piko_model)
[![Code Climate](https://codeclimate.com/github/skopciewski/piko_model/badges/gpa.svg)](https://codeclimate.com/github/skopciewski/piko_model)

Simple model which can be initialized from Hash. It is possible to define default values and check if all reqired fields are set.

## Installation

Add this line to your application's Gemfile:

    gem 'piko_model'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install piko_model

## Usage

```ruby
require "piko_model"

class Config < PikoModel::Model
  field "a"
  field "b.c", default: true
end

foo = Config.new
foo.valid? #=> false
foo.missing_fields #=> ["a"]
foo['b.c"] #=> true

bar = Config.new a: "value", "b.c": false
bar.valid? #=> true
bar.fetch("a") #=> "value"

baz = Config.new ENV.to_h
```

## Versioning

See [semver.org][semver]

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[semver]: http://semver.org/
