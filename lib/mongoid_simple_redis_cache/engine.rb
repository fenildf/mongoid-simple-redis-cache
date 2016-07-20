module MongoidSimpleRedisCache
  class Engine < ::Rails::Engine
    isolate_namespace MongoidSimpleRedisCache
    config.to_prepare do
      ApplicationController.helper ::ApplicationHelper

      Dir.glob(Rails.root + "app/decorators/mongoid_simple_redis_cache/**/*_decorator.rb").each do |c|
        require_dependency(c)
      end
    end
  end
end
