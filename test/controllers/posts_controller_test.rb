require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
  end

  #test "should get index" do
    #get posts_url
    #assert_response :success
  #end

  test "should get new" do
    get new_post_url
    assert_response :success
  end

  test "should create post" do
    assert_difference('Post.count') do
      post posts_url, params: { post: { content: @post.content, title: @post.title} }
    end

    assert_redirected_to post_url(Post.last)
  end

  test "should show post" do
    get post_url(@post)
    assert_response :success
  end

  test "should get edit" do
    get edit_post_url(@post)
    assert_response :success
  end

  test "should update post" do
    patch post_url(@post), params: { post: { content: @post.content, title: @post.title } }
    assert_redirected_to post_url(@post)
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete post_url(@post)
    end

    assert_redirected_to posts_url
  end

#<!-- code above from here is created by scaffold --> 上はscaffoldで作成されたコード

  test "should redirect create when not logged in" do #投稿する時にログインしてない場合createをリダイレクトtoログイン
    assert_no_difference 'Post.count' do
      post posts_url, params: { post: { content: @post.content, title: @post.title } }
    end
    assert_redirected_to("/users/sign_in")
  end

  test "should redirect destroy when not logged in" do #投稿を削除する時にログインしてない場合destroyをリダイレクトtoログイン
    assert_no_difference 'Post.count' do
      delete post_url(@post)
    end
    assert_redirected_to("/users/sign_in")
  end

  test "should redirect edit when not logged in" do #投稿を編集する時にログインしてない場合editをリダイレクトtoログイン
   get edit_post_url(@post)
   assert_not flash.empty?
   assert_redirected_to("/users/sign_in")
 end

 test "should redirect update when not logged in" do #投稿を編集(update)する時にログインしてない場合updateをリダイレクトtoログイン
    patch post_url(@post), params: { post: { title: @post.title,
                                              content: @post.content } }
    assert_not flash.empty?
    assert_redirected_to("/users/sign_in")
  end

end
