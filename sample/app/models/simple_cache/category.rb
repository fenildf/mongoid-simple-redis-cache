module SimpleCache
  class Category
    include Mongoid::Document
    include Mongoid::Timestamps
    include MongoidSimpleRedisCache::BaseMethods

    field :name, type: String

    def posts_of_user_db(user)
      Post.where(user_id: user.id.to_s, :category_ids.in => [self.id.to_s])
    end

    def posts_db
      Post.where(:category_ids.in => [self.id.to_s])
    end

    def posts_count_of_user_db(user)
      posts_of_user_db(user).count
    end

    def posts_count_db
      posts_db.count
    end

  end
end
