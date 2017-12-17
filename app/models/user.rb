class User < ApplicationRecord
  has_attached_file :avatar, styles: { thumb: "100x100>" }, default_url: '/images/no_avatar.jpg' # Avatarのdefault画像の設置。stylesで画像サイズを定義できる
  validates_attachment :avatar, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }  # ファイルの拡張子を指定（これがないとエラーが発生する）
  validates_attachment :avatar,presence: true, less_than: 5.megabytes # ファイルの存在&サイズチェック
  # Avatar & Paperclipの設定(ここから上の行)

  validates :profile, length: {maximum: 255} #profileの文字は255文字まで
  has_one :post, dependent: :destroy #dependent: :destroyのテストを書く13.2
  before_create :build_post #ユーザーは一つのポストだけ作成が可能
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
end
