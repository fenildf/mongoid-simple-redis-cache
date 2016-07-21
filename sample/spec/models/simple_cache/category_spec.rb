require 'rails_helper'

RSpec.describe SimpleCache::Category, type: :model do
  describe "posts_db posts_count_db" do
    it{
      user     = SimpleCache::User.create(name: "user_1")
      category = SimpleCache::Category.create(name: 'category1')
      posts = (0...10).to_a.map do |i|
        SimpleCache::Post.create!(name: "post_#{i}", user: user, categories: [category])
      end

      expect(category.posts_db).to eq(posts)
      expect(category.posts_count_db).to eq(posts.count)
    }
  end

  describe "posts_of_user_db(user) posts_count_of_user_db(user)" do
    it{
      user1    = SimpleCache::User.create(name: "user_1")
      user2    = SimpleCache::User.create(name: "user_2")
      category = SimpleCache::Category.create(name: 'category1')

      posts1 = (0...10).to_a.map do |i|
        SimpleCache::Post.create!(name: "post_#{i}", user: user1, categories: [category])
      end
      posts2 = (10...20).to_a.map do |i|
        SimpleCache::Post.create!(name: "post_#{i}", user: user2, categories: [category])
      end

      expect(category.posts_of_user_db(user1)).to eq(posts1)
      expect(category.posts_count_of_user_db(user1)).to eq(posts1.count)
    }


  end
end
