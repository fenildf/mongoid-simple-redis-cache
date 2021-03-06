module MongoidSimpleRedisCache
  module Config
    @@skip_redis_flag = false
    def self.skip_redis(&block)
      @@skip_redis_flag = true
      block.call
      @@skip_redis_flag = false
    end

    def self.get_skip_redis
      @@skip_redis_flag
    end

    def config(&block)
      instance_exec(&block)
    end

    def set_skip_redis(skip)
      if skip
        @@skip_redis_flag = true
      else
        @@skip_redis_flag = false
      end
    end

    def vector_cache(options, &block)
      name = options[:name]
      params = options[:params] || []
      caller = options[:caller]
      model = options[:model]
      raise 'vector_cache 缺少 name 参数'   if name.blank?
      raise 'vector_cache 缺少 caller 参数，或者 caller 不是一个合法的参数' if !caller.respond_to?(:field)
      raise 'vector_cache 缺少 model 参数'  if !model.respond_to?(:field)

      vector_cache = MongoidSimpleRedisCache::VectorCacheDslParser.new(name, params, caller, model)
      vector_cache.instance_exec(vector_cache, &block)
      vector_cache.register
    end

    def value_cache(options, &block)
      name = options[:name]
      params = options[:params] || []
      caller = options[:caller]
      value_type = options[:value_type] || String
      raise 'value_cache 缺少 name 参数'   if name.blank?
      raise 'vector_cache 缺少 caller 参数，或者 caller 不是一个合法的参数' if !caller.respond_to?(:field)

      value_cache = MongoidSimpleRedisCache::ValueCacheDslParser.new(name, params, caller, value_type)
      value_cache.instance_exec(value_cache, &block)
      value_cache.register
    end
  end
end
