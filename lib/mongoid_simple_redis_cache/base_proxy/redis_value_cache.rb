module MongoidSimpleRedisCache
  class RedisValueCache
    attr_reader :key

    def initialize(key)
      @key = key
      @redis = RedisCache.instance
    end

    def exists
      return false if MongoidSimpleRedisCache::Config.get_skip_redis
      @redis.exists(@key)
    end

    def value
      return nil if MongoidSimpleRedisCache::Config.get_skip_redis
      return nil if !exists
      @redis.get(@key)
    end

    def set_value(value)
      return if MongoidSimpleRedisCache::Config.get_skip_redis
      @redis.set(@key, value)
    end

    def delete
      return if MongoidSimpleRedisCache::Config.get_skip_redis
      @redis.del(@key)
    end

  end
end
