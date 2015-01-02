# Gorilla.io API client for Ruby

[![Build Status](https://travis-ci.org/thinkmechanic/gorilla-ruby.svg)](https://travis-ci.org/thinkmechanic/gorilla-ruby)

A Ruby wrapper for the [Gorilla.io](http://gorilla.io) API.

* [Gorilla.io API Docs](http://docs.gorilla.io/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gorilla-io'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gorilla-io

## Configuration

```ruby
Gorilla.configure do |c|
  # Optional (with defaults)
  c.token_duration = 5 * 60 # Tokens expire in 5 minutes
  c.api_version = 1
  c.api_url = 'https://api.gorilla.io/'

  # Required
  c.api_key = 'your-api-key'
  c.api_secret = 'your-api-secret'
end

client = Gorilla::Client.new
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/gorilla-client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
