# DeviseAuthProxy

A devise extension for proxy user authentication.

[![Gem Version](https://badge.fury.io/rb/devise_auth_proxy.svg)](http://badge.fury.io/rb/devise_auth_proxy)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'devise_auth_proxy'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install devise_auth_proxy

## Usage

Invoke hook 
* Add `:auth_proxy_authenticatable` symbol to `devise` statement in User model, before other authentication strategies (e.g., `:database_authenticatable`).
* Add `include DeviseAuthProxy::Helper` to ApplicationController to override `after_sign_out_path_for` of devise if you want to modify the redirect url after sign out.

Configuration options:
* `env_key` - String (default: 'AUTH_PROXY'). Request environment key for the proxy user id.
* `attribute_map` - Hash (default: {}). Map of User model attributes to request environment keys for updating the local user when auto-creation is enabled.
* `auto_create` - Boolean (default: false). Whether to auto-create a local user from the proxy user attributes. Note: Also requires adding the Warden callbacks as shown below.
* `auto_update` - Boolean (default: false). Whether to auto-update authenticated user attributes from proxy user attributes.
* `default_role` - List (default: []). A list of role default for new user. If your application integrate with CanCan of something like that.
* `logout_service` - String. A service to handle logout session.
* `logout_url` - String (default: '/'). For redirecting to a proxy user logout URL after signing out of the Rails application. Include DeviseAuthProxy::ControllerBehavior in your application controller to enable (by overriding Devise's after_sign_out_path_for).


Set options in a Rails initializer (e.g., `config/intializers/devise.rb`):

```
require 'devise_auth_proxy'

DeviseAuthProxy.configure do |config|
  config.env_key = 'HTTP_AUTH_PROXY'
  config.auto_create = true
  config.auto_update = true
  config.attribute_map = { email: 'mail' }
  config.default_role = ['role_name / role_id']
  config.logout_service = '<service name>'
  config.logout_url = "http://localhost:3000/logout"
end
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/me0den/devise_auth_proxy. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/me0den/devise_auth_proxy/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the DeviseAuthProxy project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/me0den/devise_auth_proxy/blob/master/CODE_OF_CONDUCT.md).
