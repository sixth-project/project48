require 'test_helper'

class PostsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:taro)
  end

  test "post interface" do
    log_in_as(@user)
    get new_post_path
    #assert_select 'div.pagination' #ページネーション
    assert_select 'input[type="file"]'
    #無効な送信
    
  end
end
