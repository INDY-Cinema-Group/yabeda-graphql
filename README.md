# Yabeda::[GraphQL][GraphQL-Ruby]

[![Build Status](https://travis-ci.org/yabeda-rb/yabeda-graphql.svg?branch=master)](https://travis-ci.org/yabeda-rb/yabeda-graphql)

Built-in metrics for [GraphQL-Ruby] monitoring out of the box! Part of the [yabeda] suite.

## Installation

 1. Add the gem to your Gemfile:

    ```ruby
    gem 'yabeda-graphql'

    # Then add monitoring system adapter, e.g.:
    # gem 'yabeda-prometheus'

    # If you're using Railsm don't forget to add plugin for it:
    # gem 'yabeda-rails'
    # But if not then you should run `Yabeda.configure!` manually when your app is ready.
    ```

    And then execute:

    ```sh
    bundle install
    ```

 2. Hook it to your schema:

    ```ruby
    class YourAppSchema < GraphQL::Schema
      use Yabeda::GraphQL::Tracing, trace_scalars: true
    end
    ```

 3. And deploy it!

**And that is it!** GraphQL metrics are being collected!

## Metrics

 - **Fields resolved count**: `graphql_fields_request_count` (segmented by `type` name, `field` name and `deprecated` flag)
 - **Field resolve runtime**: `graphql_field_resolve_runtime` (segmented by `type` name, `field` name and `deprecated` flag)
 - **Queries executed count** (root query fields): `query_fields_count` (segmented by query `name` and `deprecated` flag)
 - **Mutations executed** (root mutation fields): `mutation_fields_count` (segmented by query `name` and `deprecated` flag)

That is it for now, but more will come later.

## Development

After checking out the repo, run `bin/setup` to install dependencies.

Then, run fololowing commands to run the tests against all supported versions of [GraphQL-Ruby]:

```sh
GRAPHQL_RUBY_INTERPRETER=yes bundle exec appraisal rspec
GRAPHQL_RUBY_INTERPRETER=no  bundle exec appraisal rspec
```

You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yabeda-rb/yabeda-graphql.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

[yabeda]: https://github.com/yabeda-rb/yabeda "Extendable framework for collecting and exporting metrics from your Ruby application"
[GraphQL-Ruby]: https://graphql-ruby.org/ "Ruby implementation of GraphQL"
