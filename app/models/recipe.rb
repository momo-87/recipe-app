class Recipe < ApplicationRecord
  validates :name, presence: true, length: { maximum: 250 }
  validates :description, presence: true
  validates :cooking_time, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :preparation_time, presence: true, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :user, foreign_key: 'user_id'
  has_many :recipe_foods, dependent: :destroy
end
