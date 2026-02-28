class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :image
  has_many :recipes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :memos, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_recipes, through: :favorites, source: :recipe

  # フォローしている関係
  has_many :following_relationships,
           class_name: "Follow",
           foreign_key: :follower_id,
           dependent: :destroy

  has_many :following,
           through: :following_relationships,
           source: :followed

  # フォローされている関係
  has_many :follower_relationships,
           class_name: "Follow",
           foreign_key: :followed_id,
           dependent: :destroy

  has_many :followers,
           through: :follower_relationships,
           source: :follower

  validates :username, presence: true
  validates :email, presence: true

  def favorited?(recipe)
    favorite_recipes.include?(recipe)
  end

  def follow(user)
    following << user unless self == user
  end

  def unfollow(user)
    following.destroy(user)
  end

  def following?(user)
    following.include?(user)
  end
  
  def self.search(keyword)
    return all if keyword.blank?

    hira = Moji.kata_to_hira(keyword)

    where("users.username LIKE :q",
      q: "%#{hira}%"
    )
  end
end
