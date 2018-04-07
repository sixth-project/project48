class AddBlogpictureToBlogs < ActiveRecord::Migration[5.0]
  def change
    add_column :blogs, :blogpicture, :string
  end
end
