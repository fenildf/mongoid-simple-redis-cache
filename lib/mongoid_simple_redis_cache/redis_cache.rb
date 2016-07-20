module MongoidSimpleRedisCache
  class RedisCache
    def self.instance
      @@instance ||= Redis.new(
        host: Rails.application.secrets[:redis]["host"],
        port: Rails.application.secrets[:redis]["port"],
        db:   Rails.application.secrets[:redis]["db"]
      )
    end

    # 清空当前 readis 数据库
    def self.flushdb
      self.instance.flushdb
    end

  end
end
