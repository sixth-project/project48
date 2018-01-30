class Blog < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc)}
  validates :title, presence: true, length: { maximum: 20}
  validates :text, presence: true, length: { maximum:140}
  #BlogのTinyMCE用写真の設定
  mount_uploader :file, ImageUploader
end
