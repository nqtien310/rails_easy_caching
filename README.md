[![Gem Version](https://badge.fury.io/rb/rails_easy_caching.svg)](http://badge.fury.io/rb/rails_easy_caching)

# Rails::Easy::Caching

Simple wrapper for Rails cache, using EasyCaching is as easy as defining which methods/scopes/associations that you wanna cache.
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails-easy-caching'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails-easy-caching

## Usage

````
model User
    has_many :wifes
    cached :wifes
end
````
Then you can access the cached data:
````
sucker = User.last
sucker.cached_wifes
````
Specify the cached attributes
````
model User
    has_many :wifes
    cached :wifes, attrs: [:name, :age]
end
````
Burn cache has the same amount of easy
````
sucker = User.last
sucker.clear_cached_wifes
````

##In testing
I met a few problems with caching & testing before, so I decide it's a good thing to exclude the "Caching" from specs, therefor invoke this within test environment
````
sucker.cached_wifes
````
is just as same as
````
sucker.wifes
````

You can change this setting by putting these configurations within config/initializers/rails_easy_caching.rb
````
RailsEasyCaching.config do |config|
    config.test_exclude = false
end
````

## Contributing

1. Fork it ( https://github.com/[my-github-username]/rails-easy-caching/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
