[![CircleCI](https://circleci.com/gh/westernmilling/gman_client.svg?style=svg)](https://circleci.com/gh/westernmilling/gman_client)
[![Code Climate](https://codeclimate.com/github/westernmilling/gman_client/badges/gpa.svg)](https://codeclimate.com/github/westernmilling/gman_client)
[![Test Coverage](https://codeclimate.com/github/westernmilling/gman_client/badges/coverage.svg)](https://codeclimate.com/github/westernmilling/gman_client/coverage)
[![Dependency Status](https://gemnasium.com/westernmilling/gman_client.svg)](https://gemnasium.com/westernmilling/gman_client)
[![Gem Version](https://badge.fury.io/rb/gman_client.svg)](https://badge.fury.io/rb/gman_client)

# GmanClient

Ruby client for the gman-services Grossman API.

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
client.driver_commission_histories_by_paid_date(DATE.new)
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
