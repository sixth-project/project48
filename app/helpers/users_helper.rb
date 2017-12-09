module UsersHelper

    def current_user?(user) #current_userですか?
      user == current_user
    end

end
