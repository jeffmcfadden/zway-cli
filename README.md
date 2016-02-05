# Zway::Cli

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'zway-cli'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zway-cli

## Usage

    $ zway login

Then edit `~/.zway_config`

Now you can check levels and turn things on and off

    $ zway ZWayVDev_zway_16-0-38 level
    $ zway ZWayVDev_zway_16-0-38 on

## Other Notes

The latest session id is kept in `~/.zway_session_id` and each request attempts to use the session cookie to keep things fast. If that fails, it will try to login and set a new session cookie. If you reboot your razberry you'll be forced to setup a new session as the old ones are purged on reboot, for example.