# == Schema Information
#
# Table name: microposts
#
#  id         :bigint(8)        not null, primary key
#  content    :text(65535)
#  user_id    :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  picture    :string(255)
#

require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    # このコードは慣習的に正しくない
    # @micropost = Micropost.new(content: "Lorem ipsum", user_id: @user.id)
    @micropost = @user.microposts.build(content: "Lorem ipsum")
    # new とbuild の役目は同じ、ただ紐付けるのがbuild なだけ
    # create とは別物create == new + save , create == build + save
  end

  test "should be valid" do
    assert @micropost.valid?
  end

  test "user id should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test "content should be present" do
    @micropost.content = "   "
    assert_not @micropost.valid?
  end

  test "content should be at most 140 characters" do
    @micropost.content = "a" * 141
    assert_not @micropost.valid?
  end

  test "order should be most recent first" do
    assert_equal microposts(:most_recent), Micropost.first
  end
  
end
