class User < ApplicationRecord
  has_one :post, dependent: :destroy #dependent: :destroyのテストを書く13.2
  before_create :build_post #ユーザーは一つのポストだけ作成が可能
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
end
