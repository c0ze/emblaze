# Emblaze

I was originally going to name this as `aws-s3-deploy`. But it seems that name was taken at rubygems, along with a whole set of names like s3deploy, s3Deployer, etc, so here we are with Emblaze !

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'emblaze'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install emblaze

## Usage

Add this to your Rakefile :

    require "emblaze/tasks"

Prepare a .env file which contains

    AWS_REGION="YOUR AWS REGION"
    AWS_BUCKET_NAME=""
    AWS_ACCESS_KEY=""
    AWS_SECRET_KEY=""

Or alternatively you can pass these by settings ENVs.

To deploy the site, call

    bundle exec rake s3

The default site folder is `_site` to comply with Jekyll, this will be configurable in future versions.
The upload task will delete contents of your bucket, minify & gzip your assets, and upload to the site.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/c0ze/emblaze . This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Emblaze project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/emblaze/blob/master/CODE_OF_CONDUCT.md).
