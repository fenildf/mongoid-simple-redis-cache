module MongoidSimpleRedisCache
  class BaseDslParser

    def rules(&block)
      self.instance_exec(self, &block)
    end

    def after_save(clazz, &block)
      _after_callback(:after_save, clazz, &block)
    end

    def after_destroy(clazz, &block)
      _after_callback(:after_destroy, clazz, &block)
    end

    def after_create(clazz, &block)
      _after_callback(:after_create, clazz, &block)
    end

    private
    def _after_callback(callback_name, clazz, &block)
      @rules << {
        :class => clazz,
        callback_name => Proc.new{|clazz_instance|
          self.instance_exec(clazz_instance, &block)
        }
      }
    end
    
  end
end