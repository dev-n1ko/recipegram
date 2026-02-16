class Recipe < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :memos, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  validate :image_presence

  def self.search(keyword)
    if keyword.present?
      joins(:user).where(
        "recipes.title LIKE :keyword OR recipes.body LIKE :keyword OR users.username LIKE :keyword",
        keyword: "%#{keyword}"
      )
    else
      all
    end
  end

private

  def image_presence
    errors.add(:image,"を選択してください") unless image.attached?
  end

end
