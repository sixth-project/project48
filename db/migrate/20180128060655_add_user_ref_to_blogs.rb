class AddUserRefToBlogs < ActiveRecord::Migration[5.0]
  def change
    add_reference :blogs, :user, foreign_key: true, index: true
  end
end
