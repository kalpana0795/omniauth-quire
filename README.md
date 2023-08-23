# Omniauth Quire &nbsp;![Build Status](https://github.com/kalpana0795/omniauth-quire/actions/workflows/main.yml/badge.svg) [![Gem Version](https://badge.fury.io/rb/omniauth-quire.svg)](https://rubygems.org/gems/omniauth-quire) 
This gem contains the Quire strategy for OmniAuth.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-quire'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install omniauth-quire

## Usage

`OmniAuth::Strategies::Quire` is simply a Rack middleware. Read the OmniAuth docs for detailed instructions: https://github.com/intridea/omniauth.

Here's a quick example, adding the middleware to a Rails app in `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :quire, ENV['QUIRE_CLIENT_ID'], ENV['QUIRE_CLIENT_SECRET']
end
```

## Authentication Hash

Here's an example Authentication Hash available in `request.env['omniauth.auth']`:

```ruby
{
  "provider": "quire",
  "uid": 'Yerby_Moore',
  "info": {
    "name": "Yerby Moore",
    "email": "ym@example.com",
    "image": "https://lh3.googleusercontent.com/a/AAcHTtcLwPCZanIv5H9GHlmnqgdy4YoBDOsp6L8voGC8dcaT=s96-c",
    "urls": {
      "website": "https://yerby.example.com",
      "profile_url": "https://quire.io/u/Yerby_Moore"
    }
  },
  "credentials": {
    "token": "697720xaavd...",
    "refresh_token": "6182a91...",
    "expires_at": 1691974463,
    "expires": true
  },
  'extra': ...
}
```
<details>

<summary>Full Authentication Hash</summary>

```ruby
{
  "provider": "quire",
  "uid": 'Yerby_Moore',
  "info": {
    "name": "Yerby Moore",
    "email": "ym@example.com",
    "image": "https://lh3.googleusercontent.com/a/AAcHTtcLwPCZanIv5H9GHlmnqgdy4YoBDOsp6L8voGC8dcaT=s96-c",
    "urls": {
      "website": "https://yerby.example.com",
      "profile_url": "https://quire.io/u/Yerby_Moore"
    }
  },
  "credentials": {
    "token": "697720xaavd...",
    "refresh_token": "6182a91...",
    "expires_at": 1691974463,
    "expires": true
  },
  "extra": {
    "raw_info": {
      "oid": "G55lH4uOv7rRjVxxxNfLb19R",
      "id": "Yerby_Moore",
      "name": "Yerby Moore",
      "description": "Awesome Text",
      "icon_color": "04",
      "image": "https://lh3.googleusercontent.com/a/AAcHTtcLwPCZanIv5H9GHlmnqgdy4YoBDOsp6L8voGC8dcaT=s96-c",
      "email": "ym@example.com",
      "website": "https://yerby.example.com",
      "name_text": "Yerby Moore",
      "name_html": "Yerby Moore",
      "description_html": "Awesome Text",
      "description_text": "Awesome Text",
      "url": "https://quire.io/u/Yerby_Moore"
    }
  }
}
```
</details>

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kalpana0795/omniauth-quire. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/kalpana0795/omniauth-quire/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Omniauth::Quire project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/kalpana0795/omniauth-quire/blob/master/CODE_OF_CONDUCT.md).
