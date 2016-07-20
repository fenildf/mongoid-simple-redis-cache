module MongoidSimpleRedisCache
  class ValueCacheDslParser < BaseDslParser
    def initialize(name, params, caller)
      @proxy = Class.new(RedisValueCacheBaseProxy)
      @proxy = SimpleRedisCache::const_set("ValueCacheProxy#{@proxy.object_id}".gsub('-', '_'), @proxy)

      @name   = name
      @params = params
      @caller = caller

      @rules = []
      
      @proxy_caller_str = @caller.name.underscore
      @proxy_db_param_strs = @params.map{|s|s.to_s}
      @proxy_initialize_param_strs = [@proxy_caller_str, @proxy_db_param_strs].flatten
      @proxy_key_param_strs = [@proxy_initialize_param_strs, @name].flatten
    end

    def refresh_cache(*args)
      count = [@caller, @params].flatten.count
      arr = args[0...count]
      @proxy.new(*arr).refresh_cache
    end

    def delete_cache(*args)
      count = [@caller, @params].flatten.count
      arr = args[0...count]
      @proxy.new(*arr).refresh_cache
    end

    def register
      @proxy.class_exec @rules do |hash|
        @@rules = hash
        def self.rules
          @@rules
        end
      end

      @proxy.class_eval <<-READER, __FILE__, __LINE__ + 1
        def initialize(#{@proxy_initialize_param_strs*","})
          @key = _keygen(#{@proxy_initialize_param_strs*","}, :#{@name})

          #{@proxy_initialize_param_strs.map {|str| "@#{str} = #{str}" }*";" }
        end

        def value_db
          @#{@proxy_caller_str}.#{@name}_db(#{@proxy_db_param_strs.map{|str| "@#{str}" }*","})
        end

        def self.funcs
          {
            :class => #{@caller.name},
            :#{@name} => Proc.new {|#{@proxy_initialize_param_strs*","}|
              #{@proxy.name}.new(#{@proxy_initialize_param_strs*","}).value
            }
          }
        end

      READER
      Management.load_cache_proxy @proxy
    end

  end
end