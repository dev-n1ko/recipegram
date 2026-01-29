class Memo < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  validates :content, presence: true
end
