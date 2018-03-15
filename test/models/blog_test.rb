require 'test_helper'

class BlogTest < ActiveSupport::TestCase

  def setup
    @user = users(:taro)
    @blog = @user.blogs.build(title: "Hello world", text: "これはテストです。")
  end

  test "title should be present" do
    @blog.title = ""
    assert_not @blog.valid?
  end

  test "text should be present" do
    @blog.text = ""
    assert_not @blog.valid?
  end

  test "blog's title should be 20 letters max" do
    @blog.title = "a"*21
    assert_not @blog.valid?
  end

  test "blog's text should be 300 letters max" do
    @blog.text = "a"*301
    assert_not @blog.valid?
  end

  
end
