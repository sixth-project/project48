class AddPicture3ToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :picture3, :string
  end
end
