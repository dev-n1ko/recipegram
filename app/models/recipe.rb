class Recipe < ApplicationRecord
  belongs_to :user, counter_cache: true
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :memos, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  enum status: { draft: 0, published: 1 }

  validates :title, presence: true
  validates :body, presence: true
  validate :image_presence
  validates :title, presence: true, if: :published?
  validates :body,  presence: true, if: :published?

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

  scope :latest, -> { order(updated_at: :desc) }
  scope :oldest, -> { order(updated_at: :asc) }
  scope :most_favorited, -> { order(favorites_count: :desc) }

  
private

  def image_presence
    errors.add(:image,"を選択してください") unless image.attached?
  end

end
