[![Code Climate](https://codeclimate.com/github/michaelachrisco/gman_client/badges/gpa.svg)](https://codeclimate.com/github/michaelachrisco/gman_client) [![Test Coverage](https://codeclimate.com/github/michaelachrisco/gman_client/badges/coverage.svg)](https://codeclimate.com/github/michaelachrisco/gman_client)
# GmanClient

Gem hooks into the Grossman API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gman_client', :git => 'git@github.com:michaelachrisco/gman_client.git'
```

And then execute:

    $ bundle

Make sure to include:
* WRAP_URL: This URL is the url for the api. Example ```export WRAP_URL="http://example.com"```
* CLIENT_ID: Doorkeeper App ID. Example: ```export CLIENT_ID="1234567"```
* CLIENT_SECRET: Doorkeeper App Secret. Example: ```export CLIENT_SECRET="1234567"```
* TOKEN_URL: URL for token. Example:  ```export TOKEN_URL="http://example.com/oauth/token"```


How to use:
```Ruby
GmanClient.drivers
GmanClient.driver_commission_histories
GmanClient.driver_commission_histories_by_paid_date(DATE.new())
```

## Contributing

1. Fork it ( https://github.com/michaelachrisco/gman_client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
