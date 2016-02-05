# Zway::Cli

## Installation

Install it yourself:

    $ gem install zway-cli

## Usage

    $ zway login

Then edit `~/.zway_config`

Now you can check levels and turn things on and off

    $ zway ZWayVDev_zway_16-0-38 level
    $ zway ZWayVDev_zway_16-0-38 on

Or if you setup aliases:

    $ zway kitchen_lights level
    > off

    $ zway kitchen_lights on
    > 200 OK

    $ zway kitchen_lights level
    > on

## How to get the Device String for the Aliases, etc. ##

1.  Go to your ZWay smarthome URL.
2.  Click on the Rooms icon at the top
3.  Go to the room your device is in
4.  Click the Gear icon on the card for your device
5.  Find the "Element Name" in the Configuration View

## Other Notes

The latest session id is kept in `~/.zway_session_id` and each request attempts to use the session cookie to keep things fast. If that fails, it will try to login and set a new session cookie. If you reboot your razberry you'll be forced to setup a new session as the old ones are purged on reboot, for example.