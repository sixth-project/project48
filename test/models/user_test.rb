require 'test_helper'

class UserTest < ActiveSupport::TestCase

 def setup
   @user = users(:hanako)
 end

 test "profile should be 255 letters maximum" do #プロフィールの文字数は255文字まで
   @user.profile = "a"*256
   assert_not @user.valid?
 end


end
