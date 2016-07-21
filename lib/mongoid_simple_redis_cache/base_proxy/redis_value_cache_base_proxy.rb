module MongoidSimpleRedisCache
  class RedisValueCacheBaseProxy
    def _keygen(*args)
      args.map do |arg|
        if arg.class == String || arg.class == Symbol
          arg.to_s
        elsif arg.class == Hash && !arg[:class].blank? && !arg[:id].blank?
          "#{arg[:class].name.underscore}_#{arg[:id]}"
        else
          "#{arg.class.name.underscore}_#{arg.id}"
        end
      end*"_"
    end

    def value_db
      raise '需要实现 value_db'
    end

    def value
      cache = RedisValueCache.new(@key)
      if !cache.exists
        return refresh_cache
      end
      cache.value
    end

    def refresh_cache
      raise('cache key 未定义') if @key.nil?
      val = value_db
      RedisValueCache.new(@key).set_value(val)
      val
    end

    def delete_cache
      raise('cache key 未定义') if @key.nil?
      RedisValueCache.new(@key).delete
    end

    def custom_refresh_cache(value)
      raise('cache key 未定义') if @key.nil?
      RedisValueCache.new(@key).set_value(value)
      value
    end
  end
end
