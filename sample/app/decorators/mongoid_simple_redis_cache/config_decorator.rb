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

end
