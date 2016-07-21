module MongoidSimpleRedisCache
  class RedisCache
    def self.instance
      @@instance ||= Redis.new(
        host: ENV["redis_host"],
        port: ENV["redis_port"],
        db:   ENV["redis_db"]
      )
    end

    # 清空当前 readis 数据库
    def self.flushdb
      self.instance.flushdb
    end

  end
end
