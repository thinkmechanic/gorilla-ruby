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

Options | Default | Description
--------|---------|-------------
`api.url` | `https://api.gorilla.io` | The Gorilla API url (probably won't change this).
`api.version` | `1` | The desired Gorilla API version.
`api.key` | `ENV['GORILLA_API_KEY']` | Your Gorilla API key.
`api.secret` | `ENV['GORILLA_API_SECRET']` | Your Gorilla API secret.
`api.token_duration` | `300` (5 minutes) | Amount in seconds generated signatures are good for.
`user_agent` | `Gorilla Ruby Client/{version}` | The user agent for the client.
`client_adapter` | `Faraday.default_adapter` | Enables easily changing the adapter in a test enviornment.

#### Configuring Clients

You can configure all clients globally, or you can configure any `api` option
option from above on a per-client basis:

```ruby
Gorilla.configure do |c|
  c.api.key 'your-key'
  c.api.secret 'your-secret'
end

# Uses the global config
client = Gorilla::Client.new

# Uses the global config, overrides key & secret
client = Gorilla::Client.new({
  key: 'other-key',
  secret: 'other-secret'
})
```

You can also customize the Faraday middleware stack by passing a block to the
client that will be passed a `Faraday::Connection` and a hash of the current
`api` options. In fact, [`Gorilla::Client`](blob/master/lib/gorilla/client.rb)
is just a [`Gorilla::VanillaClient`](blob/master/lib/gorilla/vanilla_client.rb)
that does just that.

```ruby
gorilla_client = Gorilla::VanillaClient.new do |conn, options|
  conn.request :api_version, options[:version]
  conn.request :signature_auth, options
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/gorilla-client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
