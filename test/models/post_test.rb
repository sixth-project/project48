require 'test_helper'

class PostTest < ActiveSupport::TestCase

  def setup
    @user = users(:taro)
    @post = @user.build_post(title: "Hello", content: "This is test post")
  end

  test "should be valid" do #有効なポストかどうかの確認
    assert @post.valid?
  end

  test "title should be present" do #ポストのタイトルは空白はダメ
  @post.title = " "
  assert_not @post.valid?
  end

  test "content should be present" do #ポストのコンテンツは空白はダメ
  @post.content = " "
  assert_not @post.valid?
  end

  test "user_id should be present" do #画像にuser_idが存在するか
    @post.user_id = nil
    assert_not @post.valid?
  end

  test "Post's content should be 255 letters maximum" do #ポストのコンテンツは255文字までか
    @post.content = "a"*256
    assert_not @post.valid?
  end

  test "Post's title should be 50 letters maximum " do #ポストのタイトルは50文字までか
    @post.title = "a"*51
    assert_not @post.valid?
  end

  



end
