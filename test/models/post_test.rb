require 'test_helper'

class PostTest < ActiveSupport::TestCase

  def setup
    @post = Post.new(title: "Hello", content: "This is test post", picture: "orange")
  end

  test "should be valid" do #有効なポストかどうかの確認
    assert @post.valid?
  end

  test "title should be present" do #ポストのタイトルの存在性テスト
  @post.title = " "
  assert_not @post.valid?
  end

  test "content should be present" do #ポストのコンテンツの存在性テスト
  @post.content = " "
  assert_not @post.valid?
  end

  test "画像にuser_idが存在するか" do
    @post.user_id = nil
    assert_not @post.valid?
  end


end
