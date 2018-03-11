class Blog < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc)}
  validates :title, presence: true, length: { maximum: 20}
  validates :text, presence: true, length: { maximum:300}

  mount_uploaders :blogpicture, BlogPictureUploader
  serialize :blogpicture, JSON #carrierwave マルチアップロードの設定
  validates :blogpicture, presence: true
  validate :check_blogpictures #Blogにアップロードできる写真の枚数制限

   def check_blogpictures #Blogにアップロードできる写真の枚数制限
      if blogpicture.size > 2
       errors.add(:blogpicture,"は2枚迄です。")
      end
   end


end
