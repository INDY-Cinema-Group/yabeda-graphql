module Yabeda
  module GraphQL
    class Instrumentation
      def before_query(query)
        reset_cache!(query)
      end

      def after_query(query)
        cache(query).each do |_path, tags:, duration:|
          Yabeda.graphql.field_resolve_runtime.measure(tags, duration)
          Yabeda.graphql.fields_request_count.increment(tags)
        end
      end

      private

      def cache(query)
        query.context.namespace(Yabeda::GraphQL)[:field_call_cache]
      end

      def reset_cache!(query)
        query.context.namespace(Yabeda::GraphQL)[:field_call_cache] =
          Hash.new { |h,k| h[k] = { tags: {}, duration: 0.0 } }
      end
    end
  end
end
