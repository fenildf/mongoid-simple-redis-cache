MongoidSimpleRedisCache.config do

  # set_skip_redis true

  # category.posts_of_user_db(user)
  vector_cache name: :posts_of_user,
               params: [:user],
               model: Post,
               caller: Category do

    rules do

      after_save Post do |post|
        post.categories.each do |category|
          refresh_cache(category, post.user)
        end
      end

    end

  end

  # category.posts_count_of_user_db(user)
  value_cache :name   => :posts_count_of_user,
              :params => [:user],
              :value_type => Fixnum,
              :caller => Category do

    rules do

      after_save Post do |post|
        post.categories.each do |category|
          refresh_cache(category, post.user)
        end
      end

    end

  end

  # category.posts
  vector_cache :name   => :posts,
               :params => [],
               :caller => Category,
               :model  => Post do

    rules do

      after_save Post do |post|
        post.categories.each do |category|
          refresh_cache(category, post.user)
        end
      end

    end

  end

  # category.posts_count
  value_cache :name   => :posts_count,
              :params => [],
              :value_type => Fixnum,
              :caller => Category do

    rules do

      after_save Post do |post|
        post.categories.each do |category|
          refresh_cache(category, post.user)
        end
      end

    end

  end

  ##############################

  # category.posts_of_user_db(user)
  vector_cache name: :posts_of_user,
               params: [:user],
               model: SimpleCache::Post,
               caller: SimpleCache::Category do

    rules do

      after_save SimpleCache::Post do |post|
        post.categories.each do |category|
          ids = category.posts_of_user_db(post.user).map{|x|x.id.to_s}

          custom_refresh_cache(
            category,
            {class: SimpleCache::User, id:  post.user.id},
            ids)
        end
      end

    end

  end

  # category.posts_count_of_user_db(user)
  value_cache :name   => :posts_count_of_user,
              :params => [:user],
              :value_type => Fixnum,
              :caller => SimpleCache::Category do

    rules do

      after_save SimpleCache::Post do |post|
        post.categories.each do |category|
          count = category.posts_count_of_user_db(post.user)

          custom_refresh_cache(
            category,
            {class: SimpleCache::User, id:  post.user.id},
            count)
        end
      end

    end

  end

  # category.posts
  vector_cache :name   => :posts,
               :params => [],
               :caller => SimpleCache::Category,
               :model  => SimpleCache::Post do

    rules do

      after_save SimpleCache::Post do |post|
        post.categories.each do |category|
          ids = category.posts_db.map{|x|x.id.to_s}
          custom_refresh_cache(category, ids)
        end
      end

    end

  end

  # category.posts_count
  value_cache :name   => :posts_count,
              :params => [],
              :value_type => Fixnum,
              :caller => SimpleCache::Category do

    rules do

      after_save SimpleCache::Post do |post|
        post.categories.each do |category|
          count = category.posts_count_db
          custom_refresh_cache(category, count)
        end
      end

    end

  end

end
