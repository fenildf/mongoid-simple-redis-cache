module MongoidSimpleRedisCache
  class ApplicationController < ActionController::Base
    layout "mongoid_simple_redis_cache/application"

    if defined? PlayAuth
      helper PlayAuth::SessionsHelper
    end
  end
end