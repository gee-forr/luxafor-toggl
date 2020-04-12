# Luxafor Toggl Syncer

This is a small utility to synchronise your [Luxafor Flag](https://luxafor.com/flag-usb-busylight-availability-indicator/) with your [Toggl activity](https://toggl.com)

* The utility will turn your flag red if you're busy tracking time to indicate that you're busy
* The utility will turn your flag green you have stopped tracking time to indicate that you're free
* The utility will switch off your flag if you haven't tracked any time within 2 hours to indicate that you're idle

**NOTE** It might work with other webhook enabled Luxafor devices. I don't have any other ones besides the flag, which is a pretty cool gadget.

## Installation

This gem is not meant for integration into a project via a Gemfile. It is meant for running as a standalone utility.

```shell
gem install luxafor-toggl
```

## Usage

```shell
export LUXAFOR_KEY=abc123 # Get me from your luxafor app webhook settings
export TOGGL_KEY=123abc   # Get me from your toggl user account

luxafor-toggl
```

### Cron Usage

Have it sync once every 2 minutes

```cron
*/2 * * * * LUXAFOR_KEY=abc123 TOGGL_KEY=123abc /path/to/luxafor-toggl
```

### Configuration

You can control certain aspects of the utility by setting a few environment variables:

* `LUXAFOR_KEY`: Required for controlling your Luxafor flag
* `TOGGL_KEY`: Required for reading from your Toggl account
* `LUXAFOR_TOGGL_STATE_FILE`: Optional. Default: `/tmp/myuser-luxafor-toggl-state.json`. Keeps state between runs. Delete this file to reset the utility's state.
* `LUXAFOR_TOGGL_IDLE_TIME`: Optional. Default: `7200`. Time in seconds before you're considered idle.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gee-forr/luxafor-toggl. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the Luxafor::Toggl project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/gee-forr/luxafor-toggl/blob/master/CODE_OF_CONDUCT.md).
