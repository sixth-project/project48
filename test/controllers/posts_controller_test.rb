require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest

  include Warden::Test::Helpers

    def setup
      Warden.test_mode!
      @user = users(:taro)
      login_as(@user, :scope => :user)
      @post = posts(:one)
    end

  #test "should get index" do 今回は必要ない
    #get posts_url
    #assert_response :success
  #end


  #test "should get new" do　
    #get new_post_url
    #assert_response :success
  #end

  #test "should create post" do
    #picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
    #assert_difference('Post.count') do
      #post posts_url, params: { post: { title: @post.title, content: @post.content, user_id: @user.id} }
    #end

    #assert_redirected_to post_url(Post.last)
  #end

  test "should show post" do
    get post_url(@post)
    assert_response :success
  end

  test "should get edit" do
    get edit_post_url(@post)
    assert_response :success
  end

  test "should update post" do
    picture = fixture_file_upload('test/fixtures/rails.png', 'image/png') #test/fixtures/にrails.pngの画像を配置しておく
    patch post_url(@post), params: { post: { title: @post.title, content: @post.content, picture: picture} }
    assert_redirected_to post_url(@post)
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete post_url(@post)
    end

    assert_redirected_to posts_url
  end

#<!-- code above from here is created by scaffold --> 上はscaffoldで作成されたコード



end
