module MongoidSimpleRedisCache
  class Routing
    # MongoidSimpleRedisCache::Routing.mount "/mongoid_simple_redis_cache", :as => 'mongoid_simple_redis_cache'
    def self.mount(prefix, options)
      MongoidSimpleRedisCache.set_mount_prefix prefix

      Rails.application.routes.draw do
        mount MongoidSimpleRedisCache::Engine => prefix, :as => options[:as]
      end
    end
  end
end
