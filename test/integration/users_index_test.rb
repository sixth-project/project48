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


end
