module MongoidSimpleRedisCache
  class << self
    def mongoid_simple_redis_cache_config
      self.instance_variable_get(:@mongoid_simple_redis_cache_config) || {}
    end

    def set_mount_prefix(mount_prefix)
      config = MongoidSimpleRedisCache.mongoid_simple_redis_cache_config
      config[:mount_prefix] = mount_prefix
      MongoidSimpleRedisCache.instance_variable_set(:@mongoid_simple_redis_cache_config, config)
    end

    def get_mount_prefix
      mongoid_simple_redis_cache_config[:mount_prefix]
    end
  end
end

# 引用 rails engine
require 'mongoid_simple_redis_cache/engine'
require 'mongoid_simple_redis_cache/rails_routes'
