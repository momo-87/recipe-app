class Recipe < ApplicationRecord
  validates :title, presence: true, length: { maximum: 250 }
  validates :description, presence: true
  validates :cooking_time, presence: true
  validates :preparation_time, presence: true
  validates :public, presence: true

  belongs_to :user, foreign_key: 'user_id'
  has_many :recipe_foods, dependent: :destroy
end
