[![Build Status](https://travis-ci.org/westernmilling/gman_client.svg?branch=master)](https://travis-ci.org/westernmilling/gman_client) [![Coverage Status](https://coveralls.io/repos/westernmilling/gman_client/badge.svg)](https://coveralls.io/r/westernmilling/gman_client)

# GmanClient

Gem hooks into the Grossman API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gman_client', git: 'git@github.com:westernmilling/gman_client.git'
```

And then execute:

    $ bundle

## Usage

How to use:

```ruby
client = Gman::Client.new(
  url: "gman services url",
  client_id: "client id",
  client_secret: "client secret"
)
```

```ruby
client.drivers
client.driver_commission_histories
client.driver_commission_histories_by_paid_date(DATE.new())
```

## Running the tests

```bash
export GMAN_SERVICES_URL=<Gman Services URL>
export GMAN_SERVICES_CLIENT_ID=<Client ID>
export GMAN_SERVICES_CLIENT_SECRET=<Client Secret>

bundle exec rspec
```

## Contributing

1. Fork it ( https://github.com/westernmilling/gman_client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
