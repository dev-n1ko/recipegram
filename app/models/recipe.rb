class Recipe < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :memos, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  validate :image_presence


private

  def image_presence
    errors.add(:image,"を選択してください") unless image.attached?
  end

end
