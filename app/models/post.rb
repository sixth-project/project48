class Post < ApplicationRecord
  #belongs_to :user#
  #validates :user_id, presence: true#
  validates :title, presence: true
  validates :content, presence: true
  #mount_uploader :picture, PictureUploader
  #mount_uploader :picture2, Picture2Uploader
  #mount_uploader :picture3, Picture3Uploader

  #独自のバリデーションの定義（画像サイズ）
  #validate :picture_size
  #validate :picture_size2
  #validate :picture_size3

  private

  def picture_size #アップロード可能な写真のサイズの設定 08/07/アーサ
    if picture.size > 2.megabytes
        errors.add(:picture, "should be less than 2MB")
    end
  end

  def picture_size2
    if picture.size > 2.megabytes
        errors.add(:picture2, "should be less than 2MB")
    end
  end

  def picture_size3
    if picture.size > 2.megabytes
        errors.add(:picture3, "should be less than 2MB")
    end
  end

end
