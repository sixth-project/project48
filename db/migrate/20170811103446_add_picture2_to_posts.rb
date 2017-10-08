class AddPicture2ToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :picture2, :string
  end
end
