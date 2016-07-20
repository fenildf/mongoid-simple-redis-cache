module MongoidSimpleRedisCache
  class VectorCacheDslParser < BaseDslParser
    def initialize(name, params, caller, model)
      @proxy = Class.new(RedisVectorArrayCacheBaseProxy)
      @proxy = SimpleRedisCache::const_set("VectorArrayCacheProxy#{@proxy.object_id}".gsub('-', '_'), @proxy)

      @name   = name
      @params = params
      @caller = caller
      @model  = model

      @rules  = []

      @proxy_caller_str = @caller.name.underscore
      @proxy_db_param_strs = @params.map{|s|s.to_s}
      @proxy_initialize_param_strs = [@proxy_caller_str, @proxy_db_param_strs].flatten
      @proxy_key_param_strs = [@proxy_initialize_param_strs, @name].flatten
    end

    def add_to_cache(*args)
      count = [@caller, @params].flatten.count
      id = args[0]
      arr = args[1...count+1]
      @proxy.new(*arr).add_to_cache(id)
    end

    def remove_from_cache(*args)
      count = [@caller, @params].flatten.count
      id = args[0]
      arr = args[1...count+1]
      @proxy.new(*arr).remove_from_cache(id)
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

        def xxxs_ids_db
          @#{@proxy_caller_str}.#{@name}_db(#{@proxy_db_param_strs.map{|str| "@#{str}" }*","}).map(&:id)
        end

        def self.funcs
          {
            :class => #{@caller.name},
            :#{@name} => Proc.new {|#{@proxy_initialize_param_strs*","}|
              #{@proxy.name}.new(#{@proxy_initialize_param_strs*","}).get_models(#{@model})
            }
          }
        end

      READER
      Management.load_cache_proxy @proxy
    end
  end
end