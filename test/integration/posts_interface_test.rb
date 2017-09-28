require 'test_helper'

class PostsInterfaceTest < ActionDispatch::IntegrationTest

#include Devise::Test::IntegrationHelpers #Deviseヘルパーをインクルードしないとダメ
include Warden::Test::Helpers

  def setup
    Warden.test_mode!
    @user = users( :taro )
    login_as(@user, :scope => :user)
    @post = posts(:one)
    @post2 = posts(:two)
  end

 test "unsuccessful edit" do #無効なポストの編集
   get edit_post_path(@post)
   assert_template 'posts/edit'
   patch post_path(@post), params: { post: { title:  "" , content: "" } }
   assert_select 'div#error_explanation'
   assert_template 'posts/edit'
 end

 test "successful edit" do #有効なポストの編集
   get edit_post_path(@post)
   assert_template 'posts/edit'
   picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
   patch post_path(@post), params: { post: { title: @post.title , content: @post.content, picture: picture } }
   assert_not flash.empty?
   assert_redirected_to @post
   @post.reload
   #assert_equal title,  @post.title
   #assert_equal content, @post.content
 end

 test "post with picture interface" do #写真を追加したポストの検証
    get edit_post_path(@post)
    assert_select 'input[type="file"]'
    # 無効な送信
    post posts_path, params: { post: { title: "", content: "" } }
    assert_select 'div#error_explanation'
    # 有効な送信
    title = "hello"
    content = "Hoge Hoge Hoge"
    picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
    post posts_path, params: { post: { title: title, content: content, picture: picture } }
    assert assigns(:post).picture?
    follow_redirect!
    assert_match content, response.body

    # 違うユーザーのプロフィールにアクセス (削除リンクがないことを確認)
    #get user_path(users(:archer))
    #assert_select 'a', text: 'delete', count: 0
  end

  test "should not access new post page if post already exists" do #既にポストしている場合にNewポストにアクセスするとリダイレクト
    get new_post_path
    assert_redirected_to @post
  end

  test "should redirect to sign_in when access new page without login" do #ログインしてない場合NEWポストにアクセスするとリダイレクトtoログイン ensure_correct_user
    delete destroy_user_session_path
    assert_redirected_to root_url
    get new_post_url
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect to sign_in when access edit page without login" do #自分以外の投稿を編集editしようとするとリダイレクトtoログイン
    get edit_post_url(@post2)
    assert_not flash.empty?
    assert_redirected_to root_url
 end



end
