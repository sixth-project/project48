class AddImageToBlogs < ActiveRecord::Migration[5.0]
  def change
    add_column :blogs, :alt, :string
    add_column :blogs, :hint, :string
    add_column :blogs, :file, :string
  end
end
