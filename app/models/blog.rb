class Blog < ApplicationRecord
  validates :title, presence: true, length: { maximum: 20}
  validates :text, presence: true, length: { maximum:140}
end
