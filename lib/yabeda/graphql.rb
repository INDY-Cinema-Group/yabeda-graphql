require "yabeda"
require "yabeda/graphql/version"
require "yabeda/graphql/yabeda_tracing"
require "yabeda/graphql/instrumentation"

module Yabeda
  module GraphQL
    class Error < StandardError; end

    REQUEST_BUCKETS = [].freeze

    Yabeda.configure do
      group :graphql

      histogram :field_resolve_runtime, comment: "A histogram of field resolving time",
                unit: :seconds, per: :field,
                tags: %i[type field],
                buckets: REQUEST_BUCKETS

      counter :fields_request_count, comment: "A counter for specific fields requests",
              tags: %i[type field]

      counter :query_fields_count, comment: "A counter for query root fields",
              tags: %i[name]

      counter :mutation_fields_count, comment: "A counter for mutation root fields",
              tags: %i[name]
    end

    def self.use(schema)
      schema.instrument(:query, Instrumentation.new)
      schema.use YabedaTracing, trace_scalars: true
    end
  end
end
