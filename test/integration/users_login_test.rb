require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  def setup
    Warden.test_mode!
    @user = users(:taro)
  end

  test "login with valid information & valid links" do #ログイン後に正しいナビゲーションリンクが表示されてるか
    login_as(@user)
    get root_path
    assert_template 'static_pages/top'
    assert_select "a[href=?]",  new_user_session_path, count: 0
    assert_select "a[href=?]",  destroy_user_session_path
    assert_select "a[href=?]",  user_path(@user)
    assert_select "a[href=?]",  post_path(@user)
    #後でブログリンクとチャットリンクのassert_selectも追加するココに！！！！(今はない)
  end

  test "logout with valid information & valid links" do
    login_as(@user)
    logout
    get root_path
    assert_template 'static_pages/top'
    assert_select "a[href=?]",  new_user_session_path
    assert_select "a[href=?]",  destroy_user_session_path, count: 0
    assert_select "a[href=?]",  user_path(@user), count:0
    #後でブログリンクとチャットリンクのassert_selectも追加するココに！！！！(今はない)
  end

end
