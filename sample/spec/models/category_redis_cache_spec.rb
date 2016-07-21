require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "posts posts_count" do
    it{
      user     = create(:user)
      category = Category.create(name: 'category1')
      posts = (0...10).to_a.map do |i|
        Post.create!(name: "post_#{i}", user: user, categories: [category])
      end

      expect(category.posts).to eq(posts)
      expect(category.posts_count).to eq(posts.count)
    }
  end

  describe "posts_of_user(user) posts_count_of_user(user)" do
    it{
      user1     = create(:user)
      user2     = create(:user)
      category = Category.create(name: 'category1')

      posts1 = (0...10).to_a.map do |i|
        Post.create!(name: "post_#{i}", user: user1, categories: [category])
      end
      posts2 = (10...20).to_a.map do |i|
        Post.create!(name: "post_#{i}", user: user2, categories: [category])
      end

      expect(category.posts_of_user(user1)).to eq(posts1)
      expect(category.posts_count_of_user(user1)).to eq(posts1.count)
    }


  end
end
