require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @user = users(:taro)
    @other_user = users(:jiro)
    sign_in(@user)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
    patch user_url(@user), params: { user: { name: @user.name, profile: @user.profile, avatar: picture } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end

  #Admin関連のテスト

  test "should not allow the admin attribute to be edited via the web" do #web経由でAdmin属性の変更を許可しない
    sign_in(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: { user: {password: @other_user.password, password_confirmation: @other_user.password_confirmation, admin: true}}
    assert_not @other_user.reload.admin?
  end

  test "should redirect destroy when not logged in" do #ログインしないでuserを削除はリダイレクトtoログイン
    delete destroy_user_session_path(@user)
    assert_no_difference "User.count" do
      delete user_path(@user)
    end
    assert_redirected_to new_user_session_path
  end

  test "should redirect destroy when logged in as a non-admin" do #Adminじゃないでuserを削除はリダイレクトtoルートpath
    sign_in(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_path
  end

  #User profileに関するテスト

  test "should redirect to index when wrong user edit user profile" do #違うuserがプロフをeditするとリダイレクト
    sign_in(@other_user)
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to users_path
  end

  test "should redirect to index when wrong user update user profile" do #違うuserがプロフをupdateするとリダイレクト
    sign_in(@other_user)
    patch user_path(@user), params: { user: { name: @user.name, profile: @user.profile}}
    assert_not flash.empty?
    assert_redirected_to users_path
  end
end
