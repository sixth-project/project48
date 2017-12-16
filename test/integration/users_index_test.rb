require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  def setup
    Warden.test_mode!
    @admin = users(:taro)
    @non_admin = users(:jiro)
  end

  test "index as admin and delete links" do #Adminでログインしてユーザーを削除する（deleteリンクの確認)
    login_as(@admin, :scope => :user)
    get users_path
    assert_template "users/index"
    assert_select 'a[href=?]', user_path(@non_admin), text: 'Delete', method: :delete
    assert_difference "User.count", -1 do
      delete user_path(@non_admin)
    end
  end

  test "user edit without avatar" do #Userのアバターがない場合(presence true)はuserのeditでvalidatesにひっかかる
    login_as(@non_admin)
    get edit_user_path(@non_admin)
    assert_template 'users/edit'
    patch user_path(@non_admin), params: {user: {name: "jiro2", profile: "jiro2のプロフィール", avatar: "" }}
    assert_select 'div#error_explanation'
    assert_template 'users/edit'
  end

  test "user edit with avatar" do #User editでアバターを追加した正しいprofile
    picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
    login_as(@non_admin)
    get edit_user_path(@non_admin)
    assert_template 'users/edit'
    patch user_path(@non_admin), params: {user: {name: "jiro3", profile: "jiro3のプロフィール", avatar: picture}}
    assert_redirected_to user_path(@non_admin)
  end


end
