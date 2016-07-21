module SimpleCache
  class User
    include Mongoid::Document
    include Mongoid::Timestamps
    include MongoidSimpleRedisCache::BaseMethods

    field :name, type: String
  end
end
