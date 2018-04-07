require 'test_helper'

class BlogsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:taro)
    @other_user = users(:jiro)
    @blog = blogs(:one)
  end

  test "should show blog" do
    get blog_url(@blog)
    assert_response :success
  end

  #ログインしてない場合にBlogにアクセスするとsigninにリダイレクトするテスト(コールバック :authenticate_user!)

  test "should redirect to login page when access new blog page without signin" do
    get new_blog_path
    assert_not flash.empty?
    assert_redirected_to new_user_session_path
  end

  test "should redirect to login page when access create blog page without signin" do
    assert_no_difference('Blog.count') do
      post blogs_path, params: { blog: { title: "HOGE", text: "HUGE"}}
    end
    assert_not flash.empty?
    assert_redirected_to new_user_session_path
  end

  test "should redirect to login page when access index blog page without signin" do
    get blogs_path
    assert_not flash.empty?
    assert_redirected_to new_user_session_path
  end

  test "should redirect to login page when access edit blog page without signin" do
    get edit_blog_path(@blog)
    assert_not flash.empty?
    assert_redirected_to new_user_session_path
  end

  test "should redirect to login page when access update blog page without signin" do
    patch blog_path(@blog), params: { blog: { title: "DOOOO", text: "Itttt"}}
    assert_not flash.empty?
    assert_redirected_to new_user_session_path
  end

  test "should redirect to login page when access destroy blog page without signin" do
    assert_no_difference('Blog.count') do
      delete blog_path(@blog)
    end
    assert_not flash.empty?
    assert_redirected_to new_user_session_path
  end

#正しいブログのオーナーのみアクセス可能テスト

  test "should redirect to root_url when edit other users blog" do
    sign_in(@other_user)
    get edit_blog_path(@blog)
    assert_not flash.empty?
    assert_equal "この記事のアクセス権限が有りません", flash[:notice]
    assert_redirected_to root_path
  end

  test "should redirect to root_url when update other users blog" do
    sign_in(@other_user)
    patch blog_path(@blog), params: { blog: { title: "other blog", text: "user"}}
    assert_not flash.empty?
    assert_equal "この記事のアクセス権限が有りません", flash[:notice]
    assert_redirected_to root_path
  end

  test "should redirect to root_url when destroy other users blog" do
    sign_in(@other_user)
    assert_no_difference('Blog.count') do
      delete blog_path(@blog)
    end
    assert_not flash.empty?
    assert_equal "この記事のアクセス権限が有りません", flash[:notice]
    assert_redirected_to root_path
  end


end
