module MongoidSimpleRedisCache
  class RedisVectorArrayCache
    attr_reader :key
    def initialize(key)
      @key = key
      @redis = RedisCache.instance
    end

    def exists
      return false if MongoidSimpleRedisCache::Config.get_skip_redis
      @redis.exists(@key)
    end

    def all
      get
    end

    def get
      return nil if MongoidSimpleRedisCache::Config.get_skip_redis
      return nil if !exists
      id_list_json = @redis.get(@key)
      ActiveSupport::JSON.decode(id_list_json)
    end

    def set(vector_array)
      return if MongoidSimpleRedisCache::Config.get_skip_redis
      raise "参数 vector_array 不是一个数组" if !vector_array.is_a?(Array)
      @redis.set(@key,vector_array.to_json)
    end

    # 把 value 放入队列
    def push(value)
      return if MongoidSimpleRedisCache::Config.get_skip_redis
      raise "该 vector_cache 不存在" if !exists
      set((get).unshift(value))
    end

    # 删除队列中等于 value 的值
    def remove(value)
      return if MongoidSimpleRedisCache::Config.get_skip_redis
      raise "该 vector_cache 不存在" if !exists
      array_tmp = get
      array_tmp.delete(value)
      set(array_tmp)
    end

    def delete
      return if MongoidSimpleRedisCache::Config.get_skip_redis
      @redis.del(@key)
    end

  end
end
