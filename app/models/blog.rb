class Blog < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc)}
  validates :title, presence: true, length: { maximum: 20}
  validates :text, presence: true, length: { maximum:300}
  mount_uploader :blogpicture, BlogPictureUploader
  #serialize :blogpictures, JSON
  validate :blogpicture_size
  validates :blogpicture, presence: true

  def blogpicture_size
    if blogpicture.size > 5.megabytes
       errors.add(:picture, "ファイルサイズを小さくして下さい。ファイルサイズは5MB迄です")
     end
  end

end
