class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include MongoidSimpleRedisCache::BaseMethods

  field :name, type: String
  
  belongs_to :user
  has_and_belongs_to_many :categories
end
