class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :image
  has_many :recipes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :username, presence: true
  validates :email, presence: true
  
end
