class Recipe < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :title, presence: true
  validates :body, presence: true
  validate :image_presence


private

  def image_presence
    errors.add(:image,"を選択してください") unless image.attached?
  end

end
