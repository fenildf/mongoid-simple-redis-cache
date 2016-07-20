Rails.application.routes.draw do
  MongoidSimpleRedisCache::Routing.mount '/', :as => 'mongoid_simple_redis_cache'
  mount PlayAuth::Engine => '/auth', :as => :auth
  root to: "home#index"
end
