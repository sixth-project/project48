require 'test_helper'

class UserTest < ActiveSupport::TestCase

 def setup
   @user = users(:hanako)
 end

 test "user should add avatar " do #アバターのavatar_file_nameは空だとinvalid
   assert_not @user.valid?
 end

 test "profile should be 255 letters maximum" do #プロフィールの文字数は255文字まで
   @user.profile = "a"*256
   assert_not @user.valid?
 end


end
