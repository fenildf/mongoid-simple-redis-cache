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
require 'mongoid_simple_redis_cache/redis_cache'

require 'redis'
require 'mongoid_simple_redis_cache/management'
require 'mongoid_simple_redis_cache/base_methods'
require 'mongoid_simple_redis_cache/base_proxy/redis_value_cache'
require 'mongoid_simple_redis_cache/base_proxy/redis_value_cache_base_proxy'
require 'mongoid_simple_redis_cache/base_proxy/redis_vector_array_cache'
require 'mongoid_simple_redis_cache/base_proxy/redis_vector_array_cache_base_proxy'
require 'mongoid_simple_redis_cache/config'
require 'mongoid_simple_redis_cache/base_dsl_parser'
require 'mongoid_simple_redis_cache/value_cache_dsl_parser'
require 'mongoid_simple_redis_cache/vector_cache_dsl_parser'


module MongoidSimpleRedisCache
  extend MongoidSimpleRedisCache::Config
end
